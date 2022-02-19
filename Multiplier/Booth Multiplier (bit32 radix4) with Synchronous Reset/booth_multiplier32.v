`timescale 1ns/1ps

module booth_multiplier32 
    (
        input wire clk,
        input wire sync_rst,
        input wire valid,
        input wire [31:0] A,
        input wire [31:0] B,
        output wire [63:0] R,
        output wire ready
    );
    
    // load and store A
    reg [31:0] A_reg;
    always @(posedge clk)
        if(sync_rst)
            A_reg<=32'b0;
        else if(valid&ready)
            A_reg<=A;
        else 
            A_reg<=A_reg;

    // load and store PART-SUM,B
    reg [65:0] M;
    wire [34:0] PARTSUM_load;
    always @(posedge clk)
        if(sync_rst)
            M<=66'b0;
        else if(valid&ready)
            M<={33'b0,B,1'b0};
        else if((~valid)&ready)
            M<=M;
        else
            M<={PARTSUM_load,M[32:2]};
    
    // calculate PART-SUM, analyse M[2:0]
    wire [34:0] A_ext;
    assign A_ext={A_reg[31],A_reg[31],A_reg[31],A_reg};
    
    wire [34:0] M_ext;
    assign M_ext={M[65],M[65],M[65:33]};
    
    wire [34:0] A_op;
    assign A_op={35{(M[2:0]==3'b001)|(M[2:0]==3'b010)}} & A_ext                     |
                {35{(M[2:0]==3'b011)}}                  & {A_ext[33:0],1'b0}        |
                {35{(M[2:0]==3'b100)}}                  & {~A_ext[33:0]+1'b1,1'b0}  |
                {35{(M[2:0]==3'b101)|(M[2:0]==3'b110)}} & (~A_ext+1'b1)             ;

    assign PARTSUM_load=M_ext+A_op;

    // get RESULT
    assign R=M[64:1];
    
    reg start;
    always @(posedge clk)
        if(sync_rst)
            start<=0;
        else
            start<=valid&ready;

    reg [3:0] count;
    always @(posedge clk)
        if(sync_rst)
            count<=4'd0;
        else if(start)
            count<=4'd1;
        else if(count==5'd15)
            count<=4'd0;
        else if(count==4'd0)
            count<=count;
        else
            count<=count+4'd1;

    assign ready=(~(|count))&(~start);
endmodule