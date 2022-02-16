`timescale 1ns/1ns
module chip_case_tb;

`define CHIP_TEST(ID, A1, B1, C1, D1, A2, B2, C2, D2, OUT1, OUT2)  \
    p1a=A1;\
    p1b=B1;\
    p1c=C1;\
    p1d=D1;\
    p2a=A2;\
    p2b=B2;\
    p2c=C2;\
    p2d=D2;\
    #5; \
    if(p1y== OUT1 && p2y==OUT2) \
        $display("Case %d passed!", ID); \
    else begin \
        $display("Case %d failed!", ID); \
        $finish; \
    end \
    #5;

  reg  p1a ;
  reg  p1b ;
  reg  p1c ;
  reg  p1d ;
  reg  p2a ;
  reg  p2b ;
  reg  p2c ;
  reg  p2d ;
  wire  p1y;
  wire  p2y;

  chip_case x_chip_case (
    .p1a (p1a ),
    .p1b (p1b ),
    .p1c (p1c ),
    .p1d (p1d ),
    .p2a (p2a ),
    .p2b (p2b ),
    .p2c (p2c ),
    .p2d (p2d ),
    .p1y (p1y ),
    .p2y  ( p2y)
  );

  initial begin
    `CHIP_TEST(8'd1, 1'b0, 1'b0, 1'b0,1'b0,1'b0, 1'b0, 1'b0,1'b0,1'b1,1'b1);
    `CHIP_TEST(8'd2, 1'b0, 1'b0, 1'b0,1'b1,1'b0, 1'b0, 1'b1,1'b1,1'b1,1'b1);
    `CHIP_TEST(8'd3, 1'b0, 1'b0, 1'b1,1'b1,1'b0, 1'b1, 1'b1,1'b1,1'b1,1'b1);
    `CHIP_TEST(8'd4, 1'b0, 1'b0, 1'b1,1'b0,1'b1, 1'b1, 1'b1,1'b1,1'b1,1'b0);
    `CHIP_TEST(8'd5, 1'b0, 1'b1, 1'b0,1'b0,1'b0, 1'b1, 1'b0,1'b1,1'b1,1'b1);
    `CHIP_TEST(8'd6, 1'b0, 1'b1, 1'b0,1'b1,1'b0, 1'b0, 1'b1,1'b0,1'b1,1'b1);
    `CHIP_TEST(8'd7, 1'b1, 1'b1, 1'b1,1'b1,1'b0, 1'b1, 1'b0,1'b1,1'b0,1'b1);
    `CHIP_TEST(8'd8, 1'b1, 1'b1, 1'b1,1'b1,1'b1, 1'b1, 1'b1,1'b1,1'b0,1'b0);
    $display("Success!");
    $finish;
  end


endmodule
