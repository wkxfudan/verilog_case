module prienc_8to3 (
    input wire a0,
    input wire a1,
    input wire a2,
    input wire a3,
    input wire a4,
    input wire a5,
    input wire a6,
    input wire a7,
    output wire [2:0] out
);

    assign out = a7 ? 3'b111 :
                 a6 ? 3'b110 :
                 a5 ? 3'b101 :
                 a4 ? 3'b100 :
                 a3 ? 3'b011 :
                 a2 ? 3'b010 :
                 a1 ? 3'b001 :
                 3'b000;

endmodule //enc_4to2