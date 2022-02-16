`timescale 1ns / 1ps

module synrefsm1_tb;
`define synrefsm1_TEST(ID,CLK,RESET,IN,OUT)\
      clk=CLK;\
      reset=RESET;\
      in=IN;\
      if(out==OUT)\
        $display("Case %d passed!", ID); \
      else begin\
        $display("Case %d failed!", ID); \
        $finish;\
        end\
        
reg clk;
reg reset;
reg in;
wire out;

synrefsm1 x_synrefsm1(
      .clk(clk),
      .reset(reset),
      .in(in),
      .out(out)
);
always #5 clk=~clk;
initial
       begin
       clk<=1'b0;
       reset<=1'b1;
       in<=1'b1;
       #5
       reset<=1'b0;
       #5
       `synrefsm1_TEST(8'd1,1'b0,1'b0,1'b1,1'b1);
       #5
       `synrefsm1_TEST(8'd2,1'b1,1'b0,1'b1,1'b1);
       #5
       in<=1'b0;
       `synrefsm1_TEST(8'd3,1'b0,1'b0,1'b1,1'b1);
       #5
       `synrefsm1_TEST(8'd4,1'b1,1'b0,1'b0,1'b1);
       #5
       in<=1'b1;
       `synrefsm1_TEST(8'd5,1'b0,1'b0,1'b0,1'b0);
       #5
       `synrefsm1_TEST(8'd6,1'b1,1'b0,1'b1,1'b0);
       #5
       in<=1'b0;
       `synrefsm1_TEST(8'd7,1'b0,1'b0,1'b1,1'b0);
       #5
       `synrefsm1_TEST(8'd8,1'b1,1'b0,1'b0,1'b0);
       #5
       `synrefsm1_TEST(8'd9,1'b0,1'b0,1'b0,1'b1);
       #5
       in<=1'b1;
       reset<=1'b1;
       `synrefsm1_TEST(8'd10,1'b1,1'b0,1'b0,1'b1);
       #5
       `synrefsm1_TEST(8'd11,1'b0,1'b1,1'b1,1'b0);
       #5
       `synrefsm1_TEST(8'd12,1'b1,1'b1,1'b1,1'b0);
       #5
       `synrefsm1_TEST(8'd13,1'b0,1'b1,1'b1,1'b1);
       $display("Success!");
       $finish;
       end
endmodule




