`timescale 1ns / 1ps

module reg_file 
#(parameter N = 8,W = 2) 
    (
         input  clk,clr,
         input  wr_en,      //write_enable
         input [W-1:0] w_addr,r_addr,
         input [N-1:0] w_data,
         output  [N-1:0]  r_data  
    );
      //register file with synchronous reset
        reg [N-1:0] array_reg[2**W-1:0];
        integer i;  //used for traversing the register
        always @(posedge clk) 
            if(clr) 
                for(i=0;i<2**W;i=i+1) array_reg[i]=0;
            else
                if(wr_en)
                array_reg[w_addr] <= w_data;
        assign r_data = array_reg[r_addr];
endmodule