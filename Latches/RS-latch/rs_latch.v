`timescale 1ns / 1ps

module rs_latch(r,s,q);
input r,s;
output reg q;
    
    always@(r,s)
    begin
        case({r,s})
        2'b00:  q<=q;
        2'b01:  q<=1'b1;
        2'b10:  q<=1'b0;
        default:q<=q;
        endcase
    end
     
endmodule