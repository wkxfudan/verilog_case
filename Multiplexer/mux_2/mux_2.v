module mux_2
#(
    parameter DW = 1
)
(
    input  wire [DW-1:0] a,
    input  wire [DW-1:0] b,
    input  wire          sel,
    output wire [DW-1:0] out
);

    assign out = (sel == 0) ? a : b;

endmodule