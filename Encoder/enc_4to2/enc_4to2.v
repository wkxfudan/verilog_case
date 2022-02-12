module enc_4to2 (
    input wire a0,
    input wire a1,
    input wire a2,
    input wire a3,
    output wire [1:0] out
);

    assign out[1] = a3 | a2;
    assign out[0] = a3 | a1;

endmodule //enc_4to2