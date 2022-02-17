//RS flip-flop
module RSFF_1(r,s,clk,q);
input r,s,clk;
output reg q;

    always@(posedge clk)
    begin
        case({r,s})
            2'b00: q<=q;
            2'b01: q<=1'b1;
            2'b10: q<=1'b0;
            default:q<=q;
        endcase
    end
endmodule