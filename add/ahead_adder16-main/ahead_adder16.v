`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/17 18:08:50
// Design Name: 
// Module Name: ahead_adder16
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


module ahead_adder16
(
input [15:0]A,
input [15:0]B,
input CIN,
output reg [15:0]S,
output reg cout 
);

wire [15:0]G=A&B;
wire [15:0]P=A|B;
reg [3:0]cin;
reg cout1;

task ahead_adder4;

input cin;
input [3:0]A;
input [3:0]B;
input [3:0]G;
input [3:0]P;
output  reg [3:0]S;
output  reg cout;
reg [3:0]C;
begin
C[0]= G[0] | (cin&P[0]);
C[1]= G[1] | (P[1]&G[0]) | (P[1]&P[0]&cin);
C[2]= G[2] | (P[2]&G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&cin);
C[3]= G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&cin);

S[0]=A[0]^B[0]^cin;
S[1]=A[1]^B[1]^C[0];
S[2]=A[2]^B[2]^C[1];
S[3]=A[3]^B[3]^C[2];
cout=C[3];
end
endtask
task ahead_carry;

input cin;
input [15:0]G;
input [15:0]P;
output reg [3:0]cout;
reg [3:0]G2;
reg [3:0]P2;
begin

G2[0]=G[3] | P[3]&G[2] | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0];
G2[1]=G[7] | P[7]&G[6] | P[7]&P[6]&G[5] | P[7]&P[6]&P[5]&G[4];
G2[2]=G[11] | P[11]&G[10] | P[11]&P[10]&G[9] | P[11]&P[10]&P[9]&G[8];
G2[3]=G[15] | P[15]&G[14] | P[15]&P[14]&G[13] | P[15]&P[14]&P[13]&G[12];

P2[0]=P[3]&P[2]&P[1]&P[0];
P2[1]=P[7]&P[6]&P[5]&P[4];
P2[2]=P[11]&P[10]&P[9]&P[8];
P2[3]=P[15]&P[14]&P[13]&P[12];

cout[0]=G2[0] | (cin&P2[0]);
cout[1]=G2[1] | (P2[1]&G2[0]) | (P2[1]&P2[0]&cin);
cout[2]=G2[2] | (P2[2]&G2[1]) | (P2[2]&P2[1]&G2[0]) | (P2[2]&P2[1]&P2[0]&cin);
cout[3]=G2[3] | (P2[3]&G2[2]) | (P2[3]&P2[2]&G2[1]) | (P2[3]&P2[2]&P2[1]&G2[0]) | (P2[3]&P2[2]&P2[1]&P2[0]&cin);
end
endtask

always@(*)
begin
	ahead_carry(CIN,G[15:0],P[15:0],cin[3:0]);
	ahead_adder4 (CIN,A[3:0],B[3:0],G[3:0],P[3:0],S[3:0],cout1);//因为进位值实际上已经被算出来了，所以这个cout1就没有实际意义
	ahead_adder4 (cin[0],A[7:4],B[7:4],G[7:4],P[7:4],S[7:4],cout1);
	ahead_adder4 (cin[1],A[11:8],B[11:8],G[11:8],P[11:8],S[11:8],cout1);
	ahead_adder4 (cin[2],A[15:12],B[15:12],G[15:12],P[15:12],S[15:12],cout);//但是这个cout有实际意义，因为超前进位算出的是四个adder的低位进位值，没有算最后一个的高位进位，所以要保留
end
endmodule
