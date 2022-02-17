`timescale 1ns / 1ps

module reg_file1_tb
#(parameter N = 8,W = 2) ();
reg clk,clr,wr_en;
reg [W-1:0] w_addr,r_addr;
reg [N-1:0]  w_data;
wire [N-1:0] r_data;

reg [6:0]test=7'b0000000;

    reg_file test1_regfile( .clk(clk), .clr(clr), .wr_en(wr_en), .w_addr(w_addr), .r_addr(r_addr), .w_data(w_data), .r_data(r_data) );
    

    initial clk=0;
    always #50 clk=~clk;  //generate clock: 100ps per decade
    
    initial begin 
     clr=1;  wr_en=0;    w_addr=0;       r_addr=0;      w_data=0;
     //check the availability of "clr"
#100 clr=0;  wr_en=1;    w_addr=2'b10;   r_addr=2'b10;  w_data=8'b10111011;
#100 clr=0;  wr_en=1;    w_addr=2'b11;   r_addr=2'b11;  w_data=8'b11110000;
#100 clr=0;  wr_en=0;    w_addr=2'b00;   r_addr=2'b10;  w_data=8'b11110000;
    //check the functions of read and write
#100 clr=1;  wr_en=0;    w_addr=0;       r_addr=2'b10;  w_data=0;
     //clear again
     
#100 if (test==7'b1111111)  $display("Success!");
    else    $display("Incorrect");
    $finish;
    end

    initial fork
    #60     test[0]=(r_data==8'b00000000);
    #160    test[1]=(r_data==8'b10111011);
    #210    test[2]=(r_data==8'b00000000);
    #260    test[3]=(r_data==8'b11110000);
    #360    test[4]=(r_data==8'b10111011);
    #410    test[5]=(r_data==8'b10111011);
    #460    test[6]=(r_data==8'b00000000);
    
    join
    
endmodule