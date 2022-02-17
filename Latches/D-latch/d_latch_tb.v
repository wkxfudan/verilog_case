`timescale 1ns/1ps

module d_latch_tb;
    reg ena;
    reg d;
    wire q;
    
    reg test_true=1'b1;
d_latch test0(.ena(ena), .d(d), .q(q));
initial 
    begin
    ena=1; d=0; #100 test_true=(q==1'b0);
    
    ena=1; d=1; #100 test_true=(q==1'b1)&test_true;
    ena=0; d=1; #100 test_true=(q==1'b1)&test_true;
    ena=0; d=0; #100 test_true=(q==1'b1)&test_true;
    
    ena=1; d=0; #100 test_true=(q==1'b0)&test_true;
    ena=0; d=1; #100 test_true=(q==1'b0)&test_true;
    ena=0; d=0; #100 test_true=(q==1'b0)&test_true;
    end

initial begin
 #800 
    if(test_true)   $display("Success!");
    else            $display("Incorrect");
    $finish;
    end
endmodule
