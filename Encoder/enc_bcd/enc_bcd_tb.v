module enc_bcd_tb;

    reg [9:0] a;
    wire [3:0] out;
    integer idx = 0;


    `define TEST_CASE(VAR, VALUE) \
        idx = idx + 1; \
        if(VAR == VALUE) $display("Case %d passed!", idx); \
        else begin $display("Case %d failed!", idx); $finish; end 

    enc_bcd dut (
        .a(a),
        .out(out)
    );

    initial begin
        a = 10'b00_0000_0000;
        #5 `TEST_CASE(out, 4'd0);
        a = 10'b00_0000_0001;
        #5 `TEST_CASE(out, 4'd0);
        a = 10'b00_0000_0010;
        #5 `TEST_CASE(out, 4'd1);
        a = 10'b00_0000_0100;
        #5 `TEST_CASE(out, 4'd2);
        a = 10'b00_0000_1000;
        #5 `TEST_CASE(out, 4'd3);
        a = 10'b00_0001_0000;
        #5 `TEST_CASE(out, 4'd4);
        a = 10'b00_0010_0000;
        #5 `TEST_CASE(out, 4'd5);
        a = 10'b00_0100_0000;
        #5 `TEST_CASE(out, 4'd6);
        a = 10'b00_1000_0000;
        #5 `TEST_CASE(out, 4'd7);
        a = 10'b01_0000_0000;
        #5 `TEST_CASE(out, 4'd8);
        a = 10'b10_0000_0000;
        #5 `TEST_CASE(out, 4'd9);
        $display("Success!");
        $finish;
    end

endmodule