`timescale 1ns / 1ps
//JK flip-flop with synchronous reset
module JKFF_1(j,k,rst,clk,q);
input j,k,clk,rst;
output reg q;
    
    always@(posedge clk)
    begin
        if(rst) q<=1'b0;
        else 
            begin
                case({j,k})
                2'b00:  q<=q;
                2'b01:  q<=1'b0;
                2'b10:  q<=1'b1;
                2'b11:  q<=~q;
                default:q<=q;
                endcase
            end
    end

endmodule

