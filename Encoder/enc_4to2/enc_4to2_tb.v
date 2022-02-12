module enc_4to2_tb;

    reg  a0;
    reg  a1;
    reg  a2;
    reg  a3;
    wire [1:0] out;
    integer idx = 0;


    `define TEST_CASE(VAR, VALUE) \
        idx = idx + 1; \
        if(VAR == VALUE) $display("Case %d passed!", idx); \
        else begin $display("Case %d failed!", idx); $finish; end 

    enc_4to2 dut (
        .a0(a0),
        .a1(a1),
        .a2(a2),
        .a3(a3),
        .out(out)
    );

    initial begin
        {a3, a2, a1, a0} = 4'b0000;
        #5 `TEST_CASE(out, 2'b0);
        {a3, a2, a1, a0} = 4'b0001;
        #5 `TEST_CASE(out, 2'b0);
        {a3, a2, a1, a0} = 4'b0010;
        #5 `TEST_CASE(out, 2'b1);
        {a3, a2, a1, a0} = 4'b0100;
        #5 `TEST_CASE(out, 2'b10);
        {a3, a2, a1, a0} = 4'b1000;
        #5 `TEST_CASE(out, 2'b11);
        $display("Success!");
        $finish;
    end

endmodule