module enc_8to3 (
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

    assign out[2] = a7 | a6 | a5 | a4;
    assign out[1] = a3 | a2 | a7 | a6;
    assign out[0] = a3 | a1 | a7 | a5;

endmodule //enc_8to3