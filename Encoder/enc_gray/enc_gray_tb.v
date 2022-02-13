module enc_gray_tb;

    reg [7:0] a;
    wire [2:0] out;
    integer idx = 0;


    `define TEST_CASE(VAR, VALUE) \
        idx = idx + 1; \
        if(VAR == VALUE) $display("Case %d passed!", idx); \
        else begin $display("Case %d failed!", idx); $finish; end 

    enc_gray dut (
        .a(a),
        .out(out)
    );

    initial begin
        a = 8'b0000_0000;
        #5 `TEST_CASE(out, 3'b000);
        a = 8'b0000_0001;
        #5 `TEST_CASE(out, 3'b000);
        a = 8'b0000_0010;
        #5 `TEST_CASE(out, 3'b001);
        a = 8'b0000_0100;
        #5 `TEST_CASE(out, 3'b011);
        a = 8'b0000_1000;
        #5 `TEST_CASE(out, 3'b010);
        a = 8'b0001_0000;
        #5 `TEST_CASE(out, 3'b110);
        a = 8'b0010_0000;
        #5 `TEST_CASE(out, 3'b111);
        a = 8'b0100_0000;
        #5 `TEST_CASE(out, 3'b101);
        a = 8'b1000_0000;
        #5 `TEST_CASE(out, 3'b100);
        $display("Success!");
        $finish;
    end

endmodule