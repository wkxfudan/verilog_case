`timescale 1ns / 1ps

module d_latch_1(ena,rst,d,q);
input ena,d,rst;
output q;
//D latch with "reset"
assign q = (rst)? 1'b0:(ena?d:q);
        
endmodule