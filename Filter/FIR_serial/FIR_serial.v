/**********************************************************
>> Description : fir study with serial tech
>> V190403     : Fs:50Mhz, fstop:1-6Mhz, order:16, sys clk:400MHz
***********************************************************/
 
module fir_serial_low(
    input                rstn,
    input                clk,   // 系统工作时钟，400MHz
    input                en ,   // 输入数据有效信号
    input        [11:0]  xin,   // 输入混合频率的信号数据
    output               valid, // 输出数据有效信号
    output       [28:0]  yout   // 输出数据
    );
 
   //delay of input data enable
    reg [11:0]            en_r ;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            en_r[11:0]      <= 'b0 ;
        end
        else begin
            en_r[11:0]      <= {en_r[10:0], en} ;
        end
    end
 
    //fir coeficient
    wire        [11:0]   coe[7:0] ;
    assign coe[0]        = 12'd11 ;
    assign coe[1]        = 12'd31 ;
    assign coe[2]        = 12'd63 ;
    assign coe[3]        = 12'd104 ;
    assign coe[4]        = 12'd152 ;
    assign coe[5]        = 12'd198 ;
    assign coe[6]        = 12'd235 ;
    assign coe[7]        = 12'd255 ;
 
    //(1) 输入数据移位部分
    reg [2:0]            cnt ;
    integer              i, j ;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            cnt <= 3'b0 ;
        end
        else if (en || cnt != 0) begin
            cnt <= cnt + 1'b1 ;    //8个周期计数
        end
    end
 
    reg [11:0]           xin_reg[15:0];
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            for (i=0; i<16; i=i+1) begin
                xin_reg[i]  <= 12'b0;
            end
        end
        else if (cnt == 3'd0 && en) begin    //每8个周期读入一次有效数据
            xin_reg[0] <= xin ;
            for (j=0; j<15; j=j+1) begin
                xin_reg[j+1] <= xin_reg[j] ; // 数据移位
            end
        end
    end
 
    //(2) 系数对称，16个移位寄存器数据进行首位相加
    reg  [11:0]          add_a, add_b ;
    reg  [11:0]          coe_s ;
    wire [12:0]          add_s ;
    wire [2:0]           xin_index = cnt>=1 ? cnt-1 : 3'd7 ;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            add_a  <= 13'b0 ;
            add_b  <= 13'b0 ;
            coe_s  <= 12'b0 ;
        end
        else if (en_r[xin_index]) begin //from en_r[1]
            add_a  <= xin_reg[xin_index] ;
            add_b  <= xin_reg[15-xin_index] ;
            coe_s  <= coe[xin_index] ;
        end
    end
    assign add_s = {add_a} + {add_b} ;  
 
    //(3) 乘法运算，只用一个乘法
    reg        [24:0]    mout ;

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            mout   <= 25'b0 ;
        end
        else if (|en_r[8:1]) begin
            mout   <= coe_s * add_s ;  //直接乘
        end
    end
    wire                 en_mult = en_r[2];
 
    //(4) 积分累加，8组25bit数据 -> 1组 29bit 数据
    reg        [28:0]    sum ;
    reg                  valid_r ;
    //mult output en counter
    reg [4:0]            cnt_acc_r ;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            cnt_acc_r <= 'b0 ;
        end
        else if (cnt_acc_r == 5'd7) begin  //计时8个周期
            cnt_acc_r <= 'b0 ;
        end
        else if (en_mult || cnt_acc_r != 0) begin //只要en有效，计时不停
            cnt_acc_r <= cnt_acc_r + 1'b1 ;
        end
    end
 
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            sum      <= 29'd0 ;
            valid_r  <= 1'b0 ;
        end
        else if (cnt_acc_r == 5'd7) begin //在第8个累加周期输出滤波值
            sum      <= sum + mout;
            valid_r  <= 1'b1 ;
        end
        else if (en_mult && cnt_acc_r == 0) begin //初始化
            sum      <= mout ;
            valid_r  <= 1'b0 ;
        end
        else if (cnt_acc_r != 0) begin //acculating between cycles
            sum      <= sum + mout ;
            valid_r  <= 1'b0 ;
        end
    end
 
    //时钟锁存有效的输出数据，为了让输出信号不是那么频繁的变化
    reg [28:0]           yout_r ;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            yout_r <= 'b0 ;
        end
        else if (valid_r) begin
            yout_r <= sum ;
        end
    end
    assign yout = yout_r ;
 
    //(5) 输出数据有效延迟，即滤波数据丢掉前15个滤波值
    reg [4:0]    cnt_valid ;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            cnt_valid      <= 'b0 ;
        end
        else if (valid_r && cnt_valid != 5'd16) begin
            cnt_valid      <= cnt_valid + 1'b1 ;
        end
    end
    assign valid = (cnt_valid == 5'd16) & valid_r ;

endmodule