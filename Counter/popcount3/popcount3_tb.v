module popcount3_tb;

    reg [2:0] in;
    wire [1:0] out;
    integer idx = 0;

    `define TEST_CASE(VAR, VALUE) \
        idx = idx + 1; \
        if(VAR == VALUE) $display("Case %d passed!", idx); \
        else begin $display("Case %d failed!", idx); $finish; end 

    popcount3 dut (
        .in(in),
        .out(out)
    );

    initial begin
        in = 3'b000;
        #5 `TEST_CASE(out, 2'b00);
        in = 3'b001;
        #5 `TEST_CASE(out, 2'b01);
        in = 3'b010;
        #5 `TEST_CASE(out, 2'b01);
        in = 3'b011;
        #5 `TEST_CASE(out, 2'b10);
        in = 3'b100;
        #5 `TEST_CASE(out, 2'b01);
        in = 3'b101;
        #5 `TEST_CASE(out, 2'b10);
        in = 3'b110;
        #5 `TEST_CASE(out, 2'b10);
        in = 3'b111;
        #5 `TEST_CASE(out, 2'b11);
        $display("Success!");
        $finish;
    end

endmodule