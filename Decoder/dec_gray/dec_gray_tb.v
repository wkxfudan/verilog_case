module dec_gray_tb;

    reg  [2:0] in;
    wire [7:0] out;
    integer idx = 0;


    `define TEST_CASE(VAR, VALUE) \
        idx = idx + 1; \
        if(VAR == VALUE) $display("Case %d passed!", idx); \
        else begin $display("Case %d failed!", idx); $finish; end 

    dec_gray dut (
        .in(in),
        .out(out)
    );

    initial begin
        in = 3'b000;
        #5 `TEST_CASE(out, 8'b0000_0001);
        in = 3'b001;
        #5 `TEST_CASE(out, 8'b0000_0010);
        in = 3'b011;
        #5 `TEST_CASE(out, 8'b0000_0100);
        in = 3'b010;
        #5 `TEST_CASE(out, 8'b0000_1000);
        in = 3'b110;
        #5 `TEST_CASE(out, 8'b0001_0000);
        in = 3'b111;
        #5 `TEST_CASE(out, 8'b0010_0000);
        in = 3'b101;
        #5 `TEST_CASE(out, 8'b0100_0000);
        in = 3'b100;
        #5 `TEST_CASE(out, 8'b1000_0000);
        $display("Success!");
        $finish;
    end

endmodule