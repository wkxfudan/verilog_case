`timescale 1ns / 1ps
//DFF with asynchronous reset
module DFF_2(clk,rst,d,q);
    input clk,d,rst;
    output reg q;
    
    always @(posedge clk,posedge rst)
    begin
        if(rst) q<=0;
        else q<=d;
    end
endmodule