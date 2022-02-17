`timescale 1ns / 1ps

module DFF_1_tb;
reg clk,d,rst;
wire q;

reg [6:0]cases=6'b0000000;
wire result;

    initial clk=0;
    always #50 clk=~clk;
    
    DFF_1 test1_DFF(.clk(clk), .d(d), .rst(rst), .q(q));
    initial fork 
    d=0;    rst=0;  
    #100    d=1;      
    #200    d=0;      
    #300    d=1;
    #310    d=0; 
    #400    d=1;      
    #500    rst=1;
    join
    
    initial fork
    #60     cases[0]=(q==0);
    #160    cases[1]=(q==1);
    #260    cases[2]=(q==0);
    #360    cases[3]=(q==0);
    #460    cases[4]=(q==1);
    #510    cases[5]=(q==1);
    #560    cases[6]=(q==0);
    #600    if(result)  $display("Success!");
            else        $display("Incorrect");
    #610        $finish;
    join
    
    assign result=&cases;
    
endmodule