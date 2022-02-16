`timescale 1ns / 1ps

module asynrecounter15(
    input clk,
    input reset,    //asynchronous active-high reset
    output reg [3:0] q
    );
    
always@(posedge clk or posedge reset)
    begin
       if(reset)
          q<=4'b0000;
       else
          q<=q+1;
    end
endmodule
