module seg_hex_tb;

    reg  [7:0] seg;
    wire [3:0] hex;
    wire       dp;
    wire [4:0] dp_hex;
    integer idx = 0;


    `define TEST_CASE(VAR, VALUE) \
        idx = idx + 1; \
        if(VAR == VALUE) $display("Case %d passed!", idx); \
        else begin $display("Case %d failed!", idx); $finish; end 

    seg_hex dut (
        .seg(seg),
        .hex(hex),
        .dp(dp)
    );

    assign dp_hex = {dp, hex};

    initial begin
        seg = 8'h3f;
        #5 `TEST_CASE(dp_hex, 5'b0_0000);
        seg = 8'h86;
        #5 `TEST_CASE(dp_hex, 5'b1_0001);
        seg = 8'h5b;
        #5 `TEST_CASE(dp_hex, 5'b0_0010);
        seg = 8'hcf;
        #5 `TEST_CASE(dp_hex, 5'b1_0011);
        seg = 8'h66;
        #5 `TEST_CASE(dp_hex, 5'b0_0100);
        seg = 8'hed;
        #5 `TEST_CASE(dp_hex, 5'b1_0101);
        seg = 8'h7d;
        #5 `TEST_CASE(dp_hex, 5'b0_0110);
        seg = 8'h87;
        #5 `TEST_CASE(dp_hex, 5'b1_0111);
        seg = 8'h7f;
        #5 `TEST_CASE(dp_hex, 5'b0_1000);
        seg = 8'hef;
        #5 `TEST_CASE(dp_hex, 5'b1_1001);
        seg = 8'h77;
        #5 `TEST_CASE(dp_hex, 5'b0_1010);
        seg = 8'hfc;
        #5 `TEST_CASE(dp_hex, 5'b1_1011);
        seg = 8'h39;
        #5 `TEST_CASE(dp_hex, 5'b0_1100);
        seg = 8'hde;
        #5 `TEST_CASE(dp_hex, 5'b1_1101);
        seg = 8'h79;
        #5 `TEST_CASE(dp_hex, 5'b0_1110);
        seg = 8'hf1;
        #5 `TEST_CASE(dp_hex, 5'b1_1111);
        $finish;
    end

endmodule