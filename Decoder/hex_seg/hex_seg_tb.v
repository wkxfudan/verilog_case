module hex_seg_tb;

    reg  [3:0] hex;
    reg        dp;
    wire [7:0] seg;
    integer idx = 0;


    `define TEST_CASE(VAR, VALUE) \
        idx = idx + 1; \
        if(VAR == VALUE) $display("Case %d passed!", idx); \
        else begin $display("Case %d failed!", idx); $finish; end 

    hex_seg dut (
        .hex(hex),
        .dp(dp),
        .seg(seg)
    );

    initial begin
        hex = 4'h0;
        dp = 1'b0;
        #5 `TEST_CASE(seg, 8'b0011_1111);
        hex = 4'h1;
        dp = 1'b1;
        #5 `TEST_CASE(seg, 8'b1000_0110);
        hex = 4'h2;
        dp = 1'b0;
        #5 `TEST_CASE(seg, 8'b0101_1011);
        hex = 4'h3;
        dp = 1'b1;
        #5 `TEST_CASE(seg, 8'b1100_1111);
        hex = 4'h4;
        dp = 1'b0;
        #5 `TEST_CASE(seg, 8'b0110_0110);
        hex = 4'h5;
        dp = 1'b1;
        #5 `TEST_CASE(seg, 8'b1110_1101);
        hex = 4'h6;
        dp = 1'b0;
        #5 `TEST_CASE(seg, 8'b0111_1101);
        hex = 4'h7;
        dp = 1'b1;
        #5 `TEST_CASE(seg, 8'b1000_0111);
        hex = 4'h8;
        dp = 1'b0;
        #5 `TEST_CASE(seg, 8'b0111_1111);
        hex = 4'h9;
        dp = 1'b1;
        #5 `TEST_CASE(seg, 8'b1110_1111);
        hex = 4'ha;
        dp = 1'b0;
        #5 `TEST_CASE(seg, 8'b0111_0111);
        hex = 4'hb;
        dp = 1'b1;
        #5 `TEST_CASE(seg, 8'b1111_1100);
        hex = 4'hc;
        dp = 1'b0;
        #5 `TEST_CASE(seg, 8'b0011_1001);
        hex = 4'hd;
        dp = 1'b1;
        #5 `TEST_CASE(seg, 8'b1101_1110);
        hex = 4'he;
        dp = 1'b0;
        #5 `TEST_CASE(seg, 8'b0111_1001);
        hex = 4'hf;
        dp = 1'b1;
        #5 `TEST_CASE(seg, 8'b1111_0001);
        $display("Success!");
        $finish;
    end

endmodule