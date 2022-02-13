module enc_gray (
    input  wire [7:0] a,
    output wire [2:0] out
);

    assign out[2] = a[7] | a[6] | a[5] | a[4];
    assign out[1] = a[5] | a[4] | a[3] | a[2];
    assign out[0] = a[6] | a[5] | a[2] | a[1];

endmodule