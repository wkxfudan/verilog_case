`timescale 1ns / 1ps

module asynrevem_tb;
`define asynrevem_TEST(ID,CLK,RST,IN,OUT)\
      clk=CLK;\
      rst=RST;\
      in=IN;\
      if(out==OUT)\
        $display("Case %d passed!", ID); \
      else begin\
        $display("Case %d failed!", ID); \
        $finish;\
        end\
        
reg clk;
reg rst;
reg [1:0]in;
wire [1:0]out;

asynrevem x_asynrevem(
      .clk(clk),
      .rst(rst),
      .in(in),
      .out(out)
);
always #5 clk=~clk;
initial
       begin
       clk<=1'b0;
       rst<=1'b1;
       in<=2'b00;
       #5
       rst<=1'b0;
       #5
       in<=2'b01;
       `asynrevem_TEST(8'd1,1'b0,1'b0,2'b00,2'b00);
       #5
       in<=2'b00;
       `asynrevem_TEST(8'd2,1'b1,1'b0,2'b01,2'b00);
       #5
       in<=2'b01;
       `asynrevem_TEST(8'd3,1'b0,1'b0,2'b00,2'b00);
       #5
       in<=2'b00;
       `asynrevem_TEST(8'd4,1'b1,1'b0,2'b01,2'b00);
       #5
       in<=2'b01;
       `asynrevem_TEST(8'd5,1'b0,1'b0,2'b00,2'b00);
       #5
       in<=2'b00;
       `asynrevem_TEST(8'd6,1'b1,1'b0,2'b01,2'b00);
       #5
       `asynrevem_TEST(8'd7,1'b0,1'b0,2'b00,2'b10);
       #5
       `asynrevem_TEST(8'd8,1'b1,1'b0,2'b00,2'b10);
       #5
       in<=2'b10;
       `asynrevem_TEST(8'd9,1'b0,1'b0,2'b00,2'b00);
       #5
       in<=2'b00;
       `asynrevem_TEST(8'd10,1'b1,1'b0,2'b10,2'b00);
       #5
       in<=2'b10;
       `asynrevem_TEST(8'd11,1'b0,1'b0,2'b00,2'b00);
       #5
       in<=2'b00;
       `asynrevem_TEST(8'd12,1'b1,1'b0,2'b10,2'b00);
       #5
       `asynrevem_TEST(8'd13,1'b0,1'b0,2'b00,2'b11);
       #5
       `asynrevem_TEST(8'd14,1'b1,1'b0,2'b00,2'b11);
       #5
       in<=2'b01;
       `asynrevem_TEST(8'd15,1'b0,1'b0,2'b00,2'b00);
       #5
       in<=2'b00;
       `asynrevem_TEST(8'd16,1'b1,1'b0,2'b01,2'b00);
       #5
       in<=2'b10;
       `asynrevem_TEST(8'd17,1'b0,1'b0,2'b00,2'b00);
       #5
       in<=2'b00;
       `asynrevem_TEST(8'd18,1'b1,1'b0,2'b10,2'b00);
       #5
       `asynrevem_TEST(8'd19,1'b0,1'b0,2'b00,2'b10);
       #5
       `asynrevem_TEST(8'd20,1'b1,1'b0,2'b00,2'b10);
       #5
       in<=2'b10;
       `asynrevem_TEST(8'd21,1'b0,1'b0,2'b00,2'b00);
       #5
       in<=2'b00;
       `asynrevem_TEST(8'd22,1'b1,1'b0,2'b10,2'b00);
       #5
       in<=2'b01;
       `asynrevem_TEST(8'd23,1'b0,1'b0,2'b00,2'b00);
       #5
       in<=2'b00;
       `asynrevem_TEST(8'd24,1'b1,1'b0,2'b01,2'b00);
       #5
       rst<=1'b1;
       `asynrevem_TEST(8'd25,1'b0,1'b0,2'b00,2'b10);
       #5
       rst<=1'b0;
       `asynrevem_TEST(8'd26,1'b1,1'b1,2'b00,2'b00);
       #5
       `asynrevem_TEST(8'd27,1'b0,1'b0,2'b00,2'b00);
       $display("Success!");
       $finish;
       end
endmodule
