`timescale 1ns/1ns
module or_gate_tb;
`define OR_TEST(ID, A, B, OUT)  \
    a = A; \
    b = B; \
    #5; \
    if(out == OUT) \
        $display("Case %d passed!", ID); \
    else begin \
        $display("Case %d failed!", ID); \
        $display("%d",out);\
        $finish; \
    end \
    #5;
    
reg  a;
reg  b;
wire out;

or_gate x_or_gate (
    .a(a),
    .b(b),
    .out(out)
);

initial begin
    `OR_TEST(8'd1, 1'b0, 1'b0, 1'b0);
    `OR_TEST(8'd2, 1'b0, 1'b1, 1'b1);
    `OR_TEST(8'd3, 1'b1, 1'b0, 1'b1);
    `OR_TEST(8'd4, 1'b1, 1'b1, 1'b1);
    $display("Success!");
    $finish;
end

endmodule