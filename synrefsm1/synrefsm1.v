`timescale 1ns / 1ps

module synrefsm1(
    input wire clk,
    input wire reset,     //synchronous active-high reset
    input wire in,
    output reg out
    );
    reg state;
    parameter A=1'b0,B=1'b1;
    
always@(posedge clk)
    if(reset)
        begin
        state<=B;
        out<=1'b1;
        end
    else if(state==A)
         begin
          if(in==0)
            begin state<=B;out<=1'b1;end
          if(in==1)
            begin state<=A;out<=1'b0;end
         end
         else
         begin
          if(in==0)
            begin state<=A;out<=1'b0;end
          if(in==1)
            begin state<=B;out<=1'b1;end
         end
         
endmodule

