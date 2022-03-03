
`define SAFE_DESIGN

module fir_serial_low
(
   input                rstn,
   input                clk, // system clock 400MHz
   input                en ,
   input        [11:0]  xin, //
   output               valid,
   output       [28:0]  yout
);

   //input data enable
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


   //(1) input data shift
   reg [2:0]            cnt ;
   integer              i, j ;
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         cnt <= 3'b0 ;
      end
      else if (en || cnt != 0) begin
         cnt <= cnt + 1'b1 ;
      end
   end

   reg [11:0]           xin_reg[15:0];
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         for (i=0; i<16; i=i+1) begin
            xin_reg[i]  <= 12'b0;
         end
      end
      else if (cnt == 3'd0 && en) begin
         xin_reg[0] <= xin ;
         for (j=0; j<15; j=j+1) begin
            xin_reg[j+1] <= xin_reg[j] ; // data shift every clock cycle
         end
      end
   end


   //(2)expanding bit-width of data and adding them with the same coefficient
   // only one adder needed
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


   //(3) only 1 multiplier needed
   wire        [24:0]    mout ;

`ifdef SAFE_DESIGN
   wire                 en_mult ;
   wire [3:0]           index_mult = cnt>=2 ? cnt-1 : 4'd7 + cnt[0] ;
   mult_man #(13, 12)
   u_mult_single
     (.clk        (clk),
      .rstn       (rstn),
      .data_rdy   (en_r[index_mult]),
      .mult1      (add_s),
      .mult2      (coe_s),
      .res_rdy    (en_mult),   //all data valid are the same
      .res        (mout)
      );

`else
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         mout   <= 25'b0 ;
      end
      else if (|en_r[8:1]) begin
         mout   <= coe_s * add_s ;
      end
   end
   wire                 en_mult = en_r[2];
`endif

   //(4) accumulation(integrator), 8 25-bit data ------------> 1 28-bit data
   reg        [28:0]    sum ;
   reg                  valid_r ;
   //mult output en shift
   reg [4:0]            cnt_acc_r ;
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         cnt_acc_r <= 'b0 ;
      end
      else if (cnt_acc_r == 5'd7) begin         //counting 8 numbers
         cnt_acc_r <= 'b0 ;
      end
      else if (en_mult || cnt_acc_r != 0) begin //once en coming, counting continues
         cnt_acc_r <= cnt_acc_r + 1'b1 ;
      end
   end

   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         sum      <= 29'd0 ;
         valid_r  <= 1'b0 ;
      end
      else if (cnt_acc_r == 5'd7) begin //output results at 8th cycle
         sum      <= sum + mout;
         valid_r  <= 1'b1 ;
      end
      else if (en_mult && cnt_acc_r == 0) begin //initial at first cycle
         sum      <= mout ;
         valid_r  <= 1'b0 ;
      end
      else if (cnt_acc_r != 0) begin //acculating between cycles
         sum      <= sum + mout ;
         valid_r  <= 1'b0 ;
      end
   end

   //stablize the output data
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

   //(5) valid_r delay
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
