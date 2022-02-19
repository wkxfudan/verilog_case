`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/17 17:40:42
// Design Name: 
// Module Name: ahead_adder4
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


module ahead_adder4
(
input cin,
input [3:0]A,
input [3:0]B,
output  [4:0]S

);
wire [3:0]G=A&B;
wire [3:0]P=A|B;
wire [3:0]C;
 
assign C[0]= G[0] | (cin&P[0]);
assign C[1]= G[1] | (P[1]&G[0]) | (P[1]&P[0]&cin);
assign C[2]= G[2] | (P[2]&G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&cin);
assign C[3]= G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&cin);
 
assign S[0]=A[0]^B[0]^cin;
assign S[1]=A[1]^B[1]^C[0];
assign S[2]=A[2]^B[2]^C[1];
assign S[3]=A[3]^B[3]^C[2];
assign S[4]=C[3];
 
endmodule
