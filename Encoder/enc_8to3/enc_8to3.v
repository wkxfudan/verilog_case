module enc_8to3_tb;

    reg  a0;
    reg  a1;
    reg  a2;
    reg  a3;
    reg  a4;
    reg  a5;
    reg  a6;
    reg  a7;
    wire [2:0] out;
    integer idx = 0;


    `define TEST_CASE(VAR, VALUE) \
        idx = idx + 1; \
        if(VAR == VALUE) $display("Case %d passed!", idx); \
        else begin $display("Case %d failed!", idx); $finish; end 

    enc_8to3 dut (
        .a0(a0),
        .a1(a1),
        .a2(a2),
        .a3(a3),
        .a4(a4),
        .a5(a5),
        .a6(a6),
        .a7(a7),
        .out(out)
    );

    initial begin
        {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b0000_0000;
        #5 `TEST_CASE(out, 3'b000);
        {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b0000_0001;
        #5 `TEST_CASE(out, 3'b000);
        {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b0000_0010;
        #5 `TEST_CASE(out, 3'b001);
        {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b0000_0100;
        #5 `TEST_CASE(out, 3'b010);
        {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b0000_1000;
        #5 `TEST_CASE(out, 3'b011);
        {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b0001_0000;
        #5 `TEST_CASE(out, 3'b100);
        {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b0010_0000;
        #5 `TEST_CASE(out, 3'b101);
        {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b0100_0000;
        #5 `TEST_CASE(out, 3'b110);
        {a7, a6, a5, a4, a3, a2, a1, a0} = 8'b1000_0000;
        #5 `TEST_CASE(out, 3'b111);
        $display("Success!");
        $finish;
    end

endmodule