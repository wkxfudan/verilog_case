`timescale 1ns / 1ps

module RSFF_2_tb;
reg r,s,clk,rst_asyn;
wire q;

reg [4:0]Q_test=4'b0000;
wire result;
RSFF_2 test2_RSFF(.r(r),.s(s),.clk(clk),.q(q), .rst_asyn(rst_asyn));

    initial clk=0;
    always #50 clk=~clk;

    initial begin
    r=1;    s=0;    rst_asyn=0; #100    Q_test[0]=q;//q expected to be 0
    r=0;    s=0;    rst_asyn=0; #100    Q_test[1]=q;//q expected to be 0
    r=0;    s=1;    rst_asyn=0; #100    Q_test[2]=q;//q expected to be 1
    r=0;    s=0;    rst_asyn=0; #100    Q_test[3]=q;//q expected to be 1
    
    #10 rst_asyn=1; #5 Q_test[4]=q;   #5 rst_asyn=0;//q expected to be 0
    
    #50 if(result)  $display("Success!");
        else        $display("Incorrect");
        $finish;
    end
    
    reg [4:0]Q_expected=4'b01100;
    assign result=(Q_test==Q_expected);
endmodule
