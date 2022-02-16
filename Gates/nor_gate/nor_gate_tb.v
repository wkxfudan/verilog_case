`timescale 1ns/1ns
module nor_gate_tb;
`define NOR_TEST(ID, A, B, OUT)  \
    a = A; \
    b = B; \
    #5; \
    if(out == OUT) \
        $display("Case %d passed!", ID); \
    else begin \
        $display("Case %d failed!", ID); \
        $finish; \
    end \
    #5;
    
reg  a;
reg  b;
wire out;

nor_gate x_nor_gate (
    .a(a),
    .b(b),
    .out(out)
);

initial begin
    `NOR_TEST(8'd1, 1'b0, 1'b0, 1'b1);
    `NOR_TEST(8'd2, 1'b0, 1'b1, 1'b0);
    `NOR_TEST(8'd3, 1'b1, 1'b0, 1'b0);
    `NOR_TEST(8'd4, 1'b1, 1'b1, 1'b0);
    $display("Success!");
    $finish;
end

endmodule