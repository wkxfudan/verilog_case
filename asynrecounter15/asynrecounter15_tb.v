`timescale 1ns / 1ps

module asynrecounter15_tb;
`define asynrecounter15_TEST(ID,CLK,RESET,Q)\
      clk=CLK;\
      reset=RESET;\
      if(q==Q)\
        $display("Case %d passed!", ID); \
      else begin\
        $display("Case %d failed!", ID); \
        $finish;\
        end\
        
reg clk;
reg reset;
wire [3:0] q;

asynrecounter15 x_asynrecounter15(
      .clk(clk),
      .reset(reset),
      .q(q)
);
always #5 clk=~clk;
initial 
      begin
      clk<=1'b0;
      reset<=1'b1;      
      #5
      reset<=1'b0;
      #5
      `asynrecounter15_TEST(8'd1,1'b0,1'b0,4'b0000); 
      #5
      `asynrecounter15_TEST(8'd2,1'b1,1'b0,4'b0000); 
      #5
      `asynrecounter15_TEST(8'd3,1'b0,1'b0,4'b0001); 
      #5
      `asynrecounter15_TEST(8'd4,1'b1,1'b0,4'b0001); 
      #5
      `asynrecounter15_TEST(8'd5,1'b0,1'b0,4'b0010); 
      #5
      `asynrecounter15_TEST(8'd6,1'b1,1'b0,4'b0010); 
      #5
      `asynrecounter15_TEST(8'd7,1'b0,1'b0,4'b0011); 
      #5
      `asynrecounter15_TEST(8'd8,1'b1,1'b0,4'b0011); 
      #5
      `asynrecounter15_TEST(8'd9,1'b0,1'b0,4'b0100); 
      #5
      `asynrecounter15_TEST(8'd10,1'b1,1'b0,4'b0100); 
      #5
      `asynrecounter15_TEST(8'd11,1'b0,1'b0,4'b0101); 
      #5
      `asynrecounter15_TEST(8'd12,1'b1,1'b0,4'b0101); 
      #5
      `asynrecounter15_TEST(8'd13,1'b0,1'b0,4'b0110); 
      #5
      `asynrecounter15_TEST(8'd14,1'b1,1'b0,4'b0110); 
      #5
      `asynrecounter15_TEST(8'd15,1'b0,1'b0,4'b0111); 
      #5
      `asynrecounter15_TEST(8'd16,1'b1,1'b0,4'b0111); 
      #5
      `asynrecounter15_TEST(8'd17,1'b0,1'b0,4'b1000); 
      #5
      `asynrecounter15_TEST(8'd18,1'b1,1'b0,4'b1000); 
      #5
      `asynrecounter15_TEST(8'd19,1'b0,1'b0,4'b1001); 
      #5
      `asynrecounter15_TEST(8'd20,1'b1,1'b0,4'b1001); 
      #5
      `asynrecounter15_TEST(8'd21,1'b0,1'b0,4'b1010); 
      #5
      `asynrecounter15_TEST(8'd22,1'b1,1'b0,4'b1010); 
      #5
      `asynrecounter15_TEST(8'd23,1'b0,1'b0,4'b1011); 
      #5
      `asynrecounter15_TEST(8'd24,1'b1,1'b0,4'b1011); 
      #5
      `asynrecounter15_TEST(8'd25,1'b0,1'b0,4'b1100); 
      #5
      `asynrecounter15_TEST(8'd26,1'b1,1'b0,4'b1100); 
      #5
      `asynrecounter15_TEST(8'd27,1'b0,1'b0,4'b1101); 
      #5
      `asynrecounter15_TEST(8'd28,1'b1,1'b0,4'b1101); 
      #5
      `asynrecounter15_TEST(8'd29,1'b0,1'b0,4'b1110); 
      #5
      `asynrecounter15_TEST(8'd30,1'b1,1'b0,4'b1110); 
      #5
      `asynrecounter15_TEST(8'd31,1'b0,1'b0,4'b1111); 
      #5
      `asynrecounter15_TEST(8'd32,1'b1,1'b0,4'b1111); 
      #5
      `asynrecounter15_TEST(8'd33,1'b0,1'b0,4'b0000); 
      #5
      `asynrecounter15_TEST(8'd34,1'b1,1'b0,4'b0000); 
      #5
      `asynrecounter15_TEST(8'd35,1'b0,1'b0,4'b0001); 
      #5
      `asynrecounter15_TEST(8'd36,1'b1,1'b0,4'b0001);
      #5
       reset<=1'b1;
      `asynrecounter15_TEST(8'd37,1'b0,1'b0,4'b0010); 
      #2.5
       reset<=1'b0;    
      `asynrecounter15_TEST(8'd38,1'b0,1'b1,4'b0000);
      #2.5    
      `asynrecounter15_TEST(8'd39,1'b1,1'b0,4'b0000);
      #5    
      `asynrecounter15_TEST(8'd40,1'b0,1'b0,4'b0001);
      #5    
      `asynrecounter15_TEST(8'd41,1'b1,1'b0,4'b0001);
      #5    
      `asynrecounter15_TEST(8'd42,1'b0,1'b0,4'b0010);
      $display("Success!");
      $finish;
      end
      
endmodule

