module prienc_4to2 (
    input  wire a0,
    input  wire a1,
    input  wire a2,
    input  wire a3,
    output wire [1:0] out
);

    assign out = a3 ? 2'b11 :
                 a2 ? 2'b10 :
                 a1 ? 2'b01 :
                 2'b00;

endmodule