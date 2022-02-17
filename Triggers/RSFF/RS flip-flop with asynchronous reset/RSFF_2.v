`timescale 1ns / 1ps
//RS flip-flop with asynchronous reset
module RSFF_2(
    input r,s,
    input rst_asyn,
    output reg q,
    input clk
    );
    
    always @(posedge clk or posedge rst_asyn)
    begin
        casez({rst_asyn,r,s})
        3'b000: q<=q;
        3'b001: q<=1'b1;
        3'b010: q<=1'b0;
        3'b1zz: q<=1'b0;
        default:q<=q;
        endcase
    end
endmodule
