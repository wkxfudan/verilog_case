`timescale 1ns / 1ps

module rs_latch_tb(

    );
    reg R,S;
    wire Q;
    
    rs_latch test_rs_latch(.r(R), .s(S), .q(Q));
    reg [3:0]TEST_cases=4'b0000;
    wire result;
    
    assign result=&TEST_cases;
    
    initial begin 
    R=1; S=0; #100 TEST_cases[0]<=(Q==1'b0);
    R=0; S=0; #100 TEST_cases[1]<=(Q==1'b0);
    R=0; S=1; #100 TEST_cases[2]<=(Q==1'b1);
    R=0; S=0; #100 TEST_cases[3]<=(Q==1'b1);
    
    #100    if(result)  $display("Success!");
            else        $display("Incorrect");
            $finish;
    end
   
endmodule
