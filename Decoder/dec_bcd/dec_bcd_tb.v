module dec_bcd_tb;

    reg  [3:0] in;
    wire [9:0] out;
    integer idx = 0;


    `define TEST_CASE(VAR, VALUE) \
        idx = idx + 1; \
        if(VAR == VALUE) $display("Case %d passed!", idx); \
        else begin $display("Case %d failed!", idx); $finish; end 

    dec_bcd dut (
        .in(in),
        .out(out)
    );

    initial begin
        in = 4'd0;
        #5 `TEST_CASE(out, 10'b00_0000_0001);
        in = 4'd1;
        #5 `TEST_CASE(out, 10'b00_0000_0010);
        in = 4'd2;
        #5 `TEST_CASE(out, 10'b00_0000_0100);
        in = 4'd3;
        #5 `TEST_CASE(out, 10'b00_0000_1000);
        in = 4'd4;
        #5 `TEST_CASE(out, 10'b00_0001_0000);
        in = 4'd5;
        #5 `TEST_CASE(out, 10'b00_0010_0000);
        in = 4'd6;
        #5 `TEST_CASE(out, 10'b00_0100_0000);
        in = 4'd7;
        #5 `TEST_CASE(out, 10'b00_1000_0000);
        in = 4'd8;
        #5 `TEST_CASE(out, 10'b01_0000_0000);
        in = 4'd9;
        #5 `TEST_CASE(out, 10'b10_0000_0000);
        in = 4'd10;
        #5 `TEST_CASE(out, 10'b00_0000_0000);
        in = 4'd11;
        #5 `TEST_CASE(out, 10'b00_0000_0000);
        in = 4'd12;
        #5 `TEST_CASE(out, 10'b00_0000_0000);
        in = 4'd13;
        #5 `TEST_CASE(out, 10'b00_0000_0000);
        in = 4'd14;
        #5 `TEST_CASE(out, 10'b00_0000_0000);
        in = 4'd15;
        #5 `TEST_CASE(out, 10'b00_0000_0000);
        $display("Success!");
        $finish;
    end

endmodule