`timescale 1ns / 1ps

module synrefsm2(
    input wire clk,
    input wire reset,     //synchronous active-high reset
    input wire j,
    input wire k,
    output reg out
    );
    reg state;
    parameter ON=1'b1,OFF=1'b0;
    
always@(posedge clk)
    if(reset)
        begin
        state<=OFF;
        out<=1'b0;
        end
    else if(state==OFF)
         begin
          if(j==1)
            begin state<=ON;out<=1'b1;end
          if(j==0)
            begin state<=OFF;out<=1'b0;end
         end
         else
         begin
          if(k==0)
            begin state<=ON;out<=1'b1;end
          if(k==1)
            begin state<=OFF;out<=1'b0;end
         end
         
endmodule

