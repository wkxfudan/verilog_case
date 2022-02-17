`timescale 1ns / 1ps

module JKFF_2_tb;
reg clk,j,k,rst;
wire q;

reg [6:0]cases=6'b0000000;
wire result;

    initial begin
    clk=0; j=0; k=0; rst=1;   
    end
    always #50 clk=~clk;//generate clock: 100ps per decade
    
    JKFF_2 test2_JKFF(.clk(clk), .j(j), .k(k), .rst(rst), .q(q));
    
    initial fork 
    #100    begin   j=1;    k=0;    rst=0;  end  
    #200    begin   j=0;    k=1;    rst=0;  end
    #300    begin   j=1;    k=1;    rst=0;  end
    #500    begin   j=1;    k=0;    rst=0;  end
    #600    rst=1;          #610 rst=0;
    join
    
    initial fork
    #10     cases[0]=(q==0);
    #160    cases[1]=(q==1);
    #260    cases[2]=(q==0);
    #360    cases[3]=(q==1);
    #460    cases[4]=(q==0);
    #560    cases[5]=(q==1);
    #610    cases[6]=(q==0);
    #700    if(result)  $display("Success!");
            else        $display("Incorrect");
    #710        $finish;
    join
    
    assign result=&cases;
    

endmodule
