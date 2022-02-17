`timescale 1ns/1ps
module d_latch_1_tb;
    reg ena,rst;
    reg d;
    wire q;
    
    reg test_true=1'b1;
d_latch_1 test1(.ena(ena), .rst(rst),.d(d), .q(q));
initial 
    begin
    rst=0; ena=1; d=0; #100 test_true=(q==1'b0);
    
    rst=0; ena=1; d=1; #100 test_true=(q==1'b1)&test_true;
    rst=0; ena=0; d=1; #100 test_true=(q==1'b1)&test_true;
    rst=0; ena=0; d=0; #100 test_true=(q==1'b1)&test_true;
    
    rst=1; ena=0; d=0; #100 test_true=(q==1'b0)&test_true;
    rst=0; ena=0; d=1; #100 test_true=(q==1'b0)&test_true;
    rst=0; ena=0; d=0; #100 test_true=(q==1'b0)&test_true;
    end

initial begin
 #800 
    if(test_true)   $display("Success!");
    else            $display("Incorrect");
    $finish;
    end
endmodule