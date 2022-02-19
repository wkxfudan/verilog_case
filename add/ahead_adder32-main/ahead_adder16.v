`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/17 19:07:33
// Design Name: 
// Module Name: ahead_adder32
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


 //32位加法
module ahead_adder32
(
	input [31:0]A,
	input [31:0]B,
	input C_in,
	output [31:0]Result,
	output C_out
);
wire [1:0]G;wire [1:0]P;
 wire C_16;
ahead_adder16 add16_1
(
	.A(A[15:0]),
	.B(B[15:0]),
	.CIN(C_in),
	.S(Result[15:0]),
	.GM(G[0]),
	.PM(P[0])
 );
assign C_16=G[0]|P[0]&C_in;

ahead_adder16 add16_2
(
	.A(A[31:16]),
	.B(B[31:16]),
	.CIN(C_16),
	.S(Result[31:16]),
	.GM(G[1]),
	.PM(P[1])
 );
 
 assign C_out=G[1]|P[1]&G[0]|P[1]&P[0]&C_in;
endmodule
