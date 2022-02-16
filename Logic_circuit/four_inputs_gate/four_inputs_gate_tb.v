`timescale 1ns/1ns
module four_inputs_gate_tb;
`define FOUR_INPUTS_TEST(ID, A, B, C, D, OUT)  \
    a = A; \
    b = B; \
    c=C;\
    d=D;\
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
reg  d;
wire out;

four_inputs_gate x_four_inputs_gate (
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .out(out)
);

initial begin
    `FOUR_INPUTS_TEST(8'd1, 1'b0, 1'b0, 1'b0,1'b0,1'b1);
    `FOUR_INPUTS_TEST(8'd2, 1'b0, 1'b0, 1'b0,1'b1,1'b1);
    `FOUR_INPUTS_TEST(8'd3, 1'b0, 1'b0, 1'b1,1'b1,1'b0);
    `FOUR_INPUTS_TEST(8'd4, 1'b0, 1'b0, 1'b1,1'b0,1'b1);
    `FOUR_INPUTS_TEST(8'd5, 1'b0, 1'b1, 1'b0,1'b0,1'b1);
    `FOUR_INPUTS_TEST(8'd6, 1'b0, 1'b1, 1'b0,1'b1,1'b0);
    `FOUR_INPUTS_TEST(8'd7, 1'b0, 1'b1, 1'b1,1'b1,1'b1);
    `FOUR_INPUTS_TEST(8'd8, 1'b0, 1'b1, 1'b1,1'b0,1'b1);
    `FOUR_INPUTS_TEST(8'd9, 1'b1, 1'b1, 1'b0,1'b0,1'b0);
    `FOUR_INPUTS_TEST(8'd10, 1'b1, 1'b1, 1'b0,1'b1,1'b0);
    `FOUR_INPUTS_TEST(8'd11, 1'b1, 1'b1, 1'b1,1'b1,1'b1);
    `FOUR_INPUTS_TEST(8'd12, 1'b1, 1'b1, 1'b1,1'b0,1'b0);
    `FOUR_INPUTS_TEST(8'd13, 1'b1, 1'b0, 1'b0,1'b0,1'b1);
    `FOUR_INPUTS_TEST(8'd14, 1'b1, 1'b0, 1'b0,1'b1,1'b1);
    `FOUR_INPUTS_TEST(8'd15, 1'b1, 1'b0, 1'b1,1'b1,1'b1);
    `FOUR_INPUTS_TEST(8'd16, 1'b1, 1'b0, 1'b1,1'b0,1'b0);
    $display("Success!");
    $finish;
end

endmodule