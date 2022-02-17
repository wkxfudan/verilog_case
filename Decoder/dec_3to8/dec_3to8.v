module dec_3to8 (
    input  wire [2:0] in,
    output wire [7:0] out
);

    assign out[0] = in == 3'b000;
    assign out[1] = in == 3'b001;
    assign out[2] = in == 3'b010;
    assign out[3] = in == 3'b011;
    assign out[4] = in == 3'b100;
    assign out[5] = in == 3'b101;
    assign out[6] = in == 3'b110;
    assign out[7] = in == 3'b111;

endmodule