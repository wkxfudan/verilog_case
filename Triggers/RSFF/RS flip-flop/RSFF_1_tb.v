`timescale 1ns / 1ps

module RSFF_1_tb;
reg r,s,clk;
wire q;

reg [3:0]Q_test=4'b0000;
wire result;
RSFF_1 test1_RSFF(.r(r),.s(s),.clk(clk),.q(q));

    initial clk=0;
    always #50 clk=~clk;

    initial begin
    r=1;    s=0;    #100    Q_test[0]=q;//q expected to be 0
    r=0;    s=0;    #100    Q_test[1]=q;//q expected to be 0
    r=0;    s=1;    #100    Q_test[2]=q;//q expected to be 1
    r=0;    s=0;    #100    Q_test[3]=q;//q expected to be 1
    #50 if(result)  $display("Success!");
        else        $display("Incorrect");
        $finish;
    end
    
    reg [3:0]Q_expected=4'b1100;
    assign result=(Q_test==Q_expected);
endmodule
