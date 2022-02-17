module dec_bcd (
    input  wire [3:0] in,
    output reg  [9:0] out
);

    always @(*) begin
        out = 10'b0;
        case(in)
            4'd0: out[0] = 1'b1;
            4'd1: out[1] = 1'b1;
            4'd2: out[2] = 1'b1;
            4'd3: out[3] = 1'b1;
            4'd4: out[4] = 1'b1;
            4'd5: out[5] = 1'b1;
            4'd6: out[6] = 1'b1;
            4'd7: out[7] = 1'b1;
            4'd8: out[8] = 1'b1;
            4'd9: out[9] = 1'b1;
        endcase
    end

endmodule