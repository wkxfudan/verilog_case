`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/17 13:29:15
// Design Name: 
// Module Name: TEST_ADDER4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TEST_ADDER16(   );
   reg   [15:0] a;
   reg   [15:0] b;
   wire [15:0] sum;
   reg [16:0]sum_ref;
   wire cout;
   reg cin=0;
   reg clk1=1;
   reg [31:0]num_good=0;
   integer i=0,j=0;
   
ahead_adder16 U1(.A(a),
  .B(b),
  .S(sum),
  .CIN(cin),
  .cout(cout));
  
 always #1 clk1=~clk1;


  initial 
  begin
  a=-1;
  b=-1;
 for(i=0;i<=16'hFFFF;i=i+1)
 begin
 a=a+1;
 for(j=0;j<=16'hFFFF;j=j+1)
 begin
   b=b+1;
   #2;
   if({cout,sum}!=sum_ref)
   begin
   $display ("failed");
   $finish;
   end
   else num_good=num_good+1;
end
end 
$display ("success!");
$finish;
end

  
always@(posedge clk1)
begin
sum_ref<=a+b;
 end
  
   
 
  

    
endmodule


