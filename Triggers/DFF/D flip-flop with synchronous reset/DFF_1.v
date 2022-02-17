`timescale 1ns / 1ps
//DFF with synchronous reset
module DFF_1(clk,rst,d,q);
    input clk,d,rst;
    output reg q;
    
    always @(posedge clk)
    begin
        if(rst) q<=0;
        else q<=d;
    end
endmodule