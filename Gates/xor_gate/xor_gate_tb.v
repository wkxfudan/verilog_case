`timescale 1ns/1ns
module xor_gate_tb;
`define XOR_TEST(ID, A, B, OUT)  \
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

xor_gate x_xor_gate (
    .a(a),
    .b(b),
    .out(out)
);

initial begin
    `XOR_TEST(8'd1, 1'b0, 1'b0, 1'b0);
    `XOR_TEST(8'd2, 1'b0, 1'b1, 1'b1);
    `XOR_TEST(8'd3, 1'b1, 1'b0, 1'b1);
    `XOR_TEST(8'd4, 1'b1, 1'b1, 1'b0);
    $display("Success!");
    $finish;
end

endmodule