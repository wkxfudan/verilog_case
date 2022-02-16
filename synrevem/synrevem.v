`timescale 1ns / 1ps
       
module synrevem(
    input wire clk,
    input wire rst,     //synchronous active-high reset
    input wire [1:0]in,
    output reg [1:0]out
    );
    reg [2:0]cur_state,next_state;
    parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100;
    always@(posedge clk)
    if(rst)
       begin
       cur_state<=s0;
       out<=2'b00;
       end
    else
       cur_state<=next_state;
     
    always@(cur_state)
    case(cur_state)
    s0:out=2'b00;
    s1:out=2'b00;
    s2:out=2'b00;
    s3:out=2'b10;
    s4:out=2'b11;
    default:out=2'b00;
    endcase
  always@(cur_state,in[0],in[1])
    case(cur_state)
    s0:begin
       if((in[0]==0)&&(in[1]==0))
         next_state<=s0;
       else if((in[0]==1)&&(in[1]==0))
         next_state<=s1;
       else if((in[0]==0)&&(in[1]==1))
         next_state<=s2;
       else next_state<=s0;
       end 
    s1:begin
       if((in[0]==0)&&(in[1]==0))
         next_state<=s1;
       else if((in[0]==1)&&(in[1]==0))
         next_state<=s2;
       else if((in[0]==0)&&(in[1]==1))
         next_state<=s3;
       else next_state<=s0;
       end
    s2:begin
       if((in[0]==0)&&(in[1]==0))
         next_state<=s2;
       else if((in[0]==1)&&(in[1]==0))
         next_state<=s3;
       else if((in[0]==0)&&(in[1]==1))
         next_state<=s4;
       else next_state<=s0;
       end   
    s3:begin
       if((in[0]==0)&&(in[1]==0))
         next_state<=s0;
       else if((in[0]==1)&&(in[1]==0))
         next_state<=s1;
       else if((in[0]==0)&&(in[1]==1))
         next_state<=s2;
       else next_state<=s0;
       end   
    s4:begin
       if((in[0]==0)&&(in[1]==0))
         next_state<=s0;
       else if((in[0]==1)&&(in[1]==0))
         next_state<=s1;
       else if((in[0]==0)&&(in[1]==1))
         next_state<=s2;
       else next_state<=s0;
       end      
    endcase
endmodule
