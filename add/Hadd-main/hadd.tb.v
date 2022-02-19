`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/02/15 17:08:24
// Design Name: 
// Module Name: test_hadd
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


module test_hadd(

    );
    integer i=0;
    reg a,b;
    wire cout,sum;
    `define hadd(A,B,COUT,SUM)\
    a=A;\
    b=B;\
    i=i+1;\
    #5;\
    if(cout==COUT&&sum==SUM)\
    $display("case %d passed",i);\
    else begin\
    $display ("case %d failed",i);\
    $finish;\
    end;\
    
    hadd U1(.a(a),.b(b),.cout(cout),.sum(sum));
initial 
begin
 `hadd(0,0,0,0);
 `hadd(0,1,0,1);
 `hadd(1,0,0,1);
 `hadd(1,1,1,0);
 $display("success");
 $finish;
    end
    
    
endmodule
