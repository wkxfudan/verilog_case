`timescale 1ns / 1ps

module asynrefsm2_tb;
`define asynrefsm2_TEST(ID,CLK,RESET,J,K,OUT)\
      clk=CLK;\
      reset=RESET;\
      j=J;\
      k=K;\
      if(out==OUT)\
        $display("Case %d passed!", ID); \
      else begin\
        $display("Case %d failed!", ID); \
        $finish;\
        end\
        
reg clk;
reg reset;
reg j;
reg k;
wire out;

asynrefsm2 x_asynrefsm2(
      .clk(clk),
      .reset(reset),
      .j(j),
      .k(k),
      .out(out)
);
always #5 clk=~clk;
initial
       begin
       clk<=1'b0;
       reset<=1'b1;
       j<=1'b0;
       k<=1'b0;
       #5
       reset<=1'b0;
       #5
       `asynrefsm2_TEST(8'd1,1'b0,1'b0,1'b0,1'b0,1'b0);
       #5
       `asynrefsm2_TEST(8'd2,1'b1,1'b0,1'b0,1'b0,1'b0);
       #5
       j<=1'b1;
       `asynrefsm2_TEST(8'd3,1'b0,1'b0,1'b0,1'b0,1'b0);
       #5
       `asynrefsm2_TEST(8'd4,1'b1,1'b0,1'b1,1'b0,1'b0);
       #5
       j<=1'b0;
       `asynrefsm2_TEST(8'd5,1'b0,1'b0,1'b1,1'b0,1'b1);
       #5
       `asynrefsm2_TEST(8'd6,1'b1,1'b0,1'b0,1'b0,1'b1);
       #5
       k<=1'b1;
       `asynrefsm2_TEST(8'd7,1'b0,1'b0,1'b0,1'b0,1'b1);
       #5
       `asynrefsm2_TEST(8'd8,1'b1,1'b0,1'b0,1'b1,1'b1);
       #5
       k<=1'b0;
       j<=1'b1;
       `asynrefsm2_TEST(8'd9,1'b0,1'b0,1'b0,1'b1,1'b0);
       #5
       `asynrefsm2_TEST(8'd10,1'b1,1'b0,1'b1,1'b0,1'b0);
       #5
       reset<=1'b1;
       j<=1'b0;
       `asynrefsm2_TEST(8'd11,1'b0,1'b0,1'b1,1'b0,1'b1);
       #5
       reset<=1'b0;
       `asynrefsm2_TEST(8'd12,1'b1,1'b1,1'b0,1'b0,1'b0);
       #5
       `asynrefsm2_TEST(8'd13,1'b0,1'b0,1'b0,1'b0,1'b0);
       $display("Success!");
       $finish;
       end
endmodule
