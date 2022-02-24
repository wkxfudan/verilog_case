`timescale 1ns/1ps

module divider32
    (
        input wire clk,
        input wire sync_rst,
        input wire valid,
        input wire [31:0] DIVIDEND,
        input wire [31:0] DIVISOR,
        output wire [31:0] Q,
        output wire [31:0] R,
        output wire ready
    );

    // load and initialize DIVISOR; right-shift 1bit/cycle
    reg [63:0] DIVISOR_reg;
    always @(posedge clk)
        if(sync_rst)
            DIVISOR_reg<=64'b0;
        else if(valid&ready)
            DIVISOR_reg<={DIVISOR,32'b0};
        else if(start|(~ready))
            DIVISOR_reg<={DIVISOR_reg[63],DIVISOR_reg[63:1]};
        else
            DIVISOR_reg<=DIVISOR_reg;

    // load DIVIDEND; add (-DIVISOR) or not
    reg [31:0] DIVIDEND_reg;
    wire [63:0] PARTSUM;
    always @(posedge clk)
        if(sync_rst)
            DIVIDEND_reg<=32'b0;
        else if(valid&ready)
            DIVIDEND_reg<=DIVIDEND;
        else if(~ready)
            DIVIDEND_reg<=  {64{PARTSUM[63]^~DIVIDEND_reg[31]}}&PARTSUM|
                            {64{PARTSUM[63]^DIVIDEND_reg[31]}}&DIVIDEND_reg;
        else
            DIVIDEND_reg<=DIVIDEND_reg;

    // calculate PARTSUM
    wire [63:0] DIVISOR_op;
    assign DIVISOR_op=  {64{DIVIDEND_reg[31]^~DIVISOR_reg[63]}}&(~DIVISOR_reg+64'b1)|
                        {64{DIVIDEND_reg[31]^DIVISOR_reg[63]}}&(DIVISOR_reg);

    wire [63:0] DIVIDEND_ext;
    assign DIVIDEND_ext={DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],
    DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],
    DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],
    DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],
    DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],
    DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],
    DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],
    DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],DIVIDEND_reg[31],
    DIVIDEND_reg};

    assign PARTSUM=DIVIDEND_ext+DIVISOR_op;

    assign R=DIVIDEND_reg;

    // calculate Q 
    reg [31:0] Q_reg;
    always @(posedge clk)
        if(sync_rst)
            Q_reg<=32'b0;
        else if(valid&ready)
            Q_reg<=32'b0;
        else if(~ready)
            Q_reg<={Q_reg[30:0],PARTSUM[63]^~DIVIDEND_reg[31]};
        else
            Q_reg<=Q_reg;

    assign Q=   {32{DIVISOR_reg[63]^~DIVIDEND_reg[31]}}&Q_reg|
                {32{DIVISOR_reg[63]^DIVIDEND_reg[31]}}&(~Q_reg+32'b1);

    // count
    reg [1:0] start;
    always @(posedge clk)
        if(sync_rst)
            start[0]<=0;
        else if(ready)
            start[0]<=valid;
        else
            start[0]<=0;
    always @(posedge clk)
        if(sync_rst)
            start[1]<=0;
        else if(start[0])
            start[1]<=1;
        else
            start[1]<=0;

    reg [4:0] count;
    always @(posedge clk)
        if(sync_rst)
            count<=5'b0;
        else if(start)
            count<=5'b1;
        else if(ready)
            count<=5'b0;
        else
            count<=count+5'b1;

    assign ready=(~|count)&(~start[1])&(~start[0]);
endmodule