module comp_n
#(
    parameter DW = 1
)
(
    input  wire [DW-1:0] a,
    input  wire [DW-1:0] b,

    output wire          gt,
    output wire          eq,
    output wire          lt
);

    assign gt = a > b;
    assign eq = a == b;
    assign lt = ~(gt | eq);

endmodule