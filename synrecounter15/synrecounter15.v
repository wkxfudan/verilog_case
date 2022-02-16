`timescale 1ns / 1ps

module synrecounter15(
    input wire clk,
    input wire reset,   //synchronous active-high reset
    output reg [3:0] q
    );
always@(posedge clk)
      begin
         if(reset)
            q<=4'b0000;
         else
            q<=q+1;
      end
endmodule
