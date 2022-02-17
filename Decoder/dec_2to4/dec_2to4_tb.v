module dec_2to4_tb;

    reg  [1:0] in;
    wire [3:0] out;
    integer idx = 0;


    `define TEST_CASE(VAR, VALUE) \
        idx = idx + 1; \
        if(VAR == VALUE) $display("Case %d passed!", idx); \
        else begin $display("Case %d failed!", idx); $finish; end 

    dec_2to4 dut (
        .in(in),
        .out(out)
    );

    initial begin
        in = 2'b00;
        #5 `TEST_CASE(out, 4'b0001);
        in = 2'b01;
        #5 `TEST_CASE(out, 4'b0010);
        in = 2'b10;
        #5 `TEST_CASE(out, 4'b0100);
        in = 2'b11;
        #5 `TEST_CASE(out, 4'b1000);
        $display("Success!");
        $finish;
    end

endmodule