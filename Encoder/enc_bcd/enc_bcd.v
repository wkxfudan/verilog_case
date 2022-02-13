module enc_bcd (
    input  wire [9:0] a,
    output wire [3:0] out
);

    assign out[3] = a[9] | a[8];
    assign out[2] = a[7] | a[6] | a[5] | a[4];
    assign out[1] = a[7] | a[6] | a[3] | a[2];
    assign out[0] = a[9] | a[7] | a[5] | a[3] | a[1];

endmodule