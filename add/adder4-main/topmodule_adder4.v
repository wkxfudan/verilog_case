`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/15 21:38:00
// Design Name: 
// Module Name: top_module
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


module top_module(a,b,sum

    );
    input [3:0] a,b;
    output [4:0] sum;
    wire [3:1] cout;
   
    Fadd U1(.a(a[0]),
    .b(b[0]),
    .cin(0),
    .sum(sum[0]),
    .cout(cout[1]));
    
    Fadd U2(.a(a[1]),
    .b(b[1]),
    .cin(cout[1]),
    .sum(sum[1]),
    .cout(cout[2]));
    
    Fadd U3(.a(a[2]),
    .b(b[2]),
    .cin(cout[2]),
    .sum(sum[2]),
    .cout(cout[3]));
    
    Fadd U4(.a(a[3]),
    .b(b[3]),
    .cin(cout[3]),
    .sum(sum[3]),
    .cout(sum[4]));
    
    
endmodule
