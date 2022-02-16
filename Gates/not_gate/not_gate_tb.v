`timescale 1ns/1ns
module not_gate_tb;
`define NOT_TEST(ID, A, OUT)  \
    a = A; \
    #5; \
    if(out == OUT) \
        $display("Case %d passed!", ID); \
    else begin \
        $display("Case %d failed!", ID); \
        $finish; \
    end \
    #5;
    
reg  a;
wire out;

not_gate x_not_gate (
    .a(a),
    .out(out)
);

initial begin
    `NOT_TEST(8'd1, 1'b0, 1'b1);
    `NOT_TEST(8'd2, 1'b1, 1'b0);
    $display("Success!");
    $finish;
end

endmodule