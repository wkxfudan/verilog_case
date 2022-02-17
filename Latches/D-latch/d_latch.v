`timescale 1ns / 1ps

module d_latch(ena,d,q);
input ena,d;
output q;
    assign q=ena?d:q;
endmodule
