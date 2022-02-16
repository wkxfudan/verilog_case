`timescale 1ns/1ns
module three_inputs_gate_tb;
`define THREE_INPUTS_TEST(ID, A, B,C, OUT)  \
    a = A; \
    b = B; \
    c=C;\
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
reg  c;
wire out;

three_inputs_gate x_three_inputs_gate (
    .a(a),
    .b(b),
    .c(c),
    .out(out)
);

initial begin
    `THREE_INPUTS_TEST(8'd1, 1'b0, 1'b0, 1'b0,1'b0);
    `THREE_INPUTS_TEST(8'd2, 1'b0, 1'b1, 1'b0,1'b1);
    `THREE_INPUTS_TEST(8'd3, 1'b0, 1'b0, 1'b1,1'b1);
    `THREE_INPUTS_TEST(8'd4, 1'b0, 1'b1, 1'b1,1'b1);
    `THREE_INPUTS_TEST(8'd5, 1'b1, 1'b0, 1'b0,1'b1);
    `THREE_INPUTS_TEST(8'd6, 1'b1, 1'b1, 1'b0,1'b1);
    `THREE_INPUTS_TEST(8'd7, 1'b1, 1'b0, 1'b1,1'b1);
    `THREE_INPUTS_TEST(8'd8, 1'b1, 1'b1, 1'b1,1'b1);
    $display("Success!");
    $finish;
end

endmodule