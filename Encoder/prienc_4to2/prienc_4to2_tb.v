module prienc_4to2_tb;

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

    prienc_4to2 dut (
        .a0(a0),
        .a1(a1),
        .a2(a2),
        .a3(a3),
        .out(out)
    );

    initial begin
        {a3, a2, a1, a0} = 4'b0000;
        #5 `TEST_CASE(out, 2'd0);
        {a3, a2, a1, a0} = 4'b0001;
        #5 `TEST_CASE(out, 2'd0);
        {a3, a2, a1, a0} = 4'b0010;
        #5 `TEST_CASE(out, 2'd1);
        {a3, a2, a1, a0} = 4'b0011;
        #5 `TEST_CASE(out, 2'd1);
        {a3, a2, a1, a0} = 4'b0100;
        #5 `TEST_CASE(out, 2'd2);
        {a3, a2, a1, a0} = 4'b0101;
        #5 `TEST_CASE(out, 2'd2);
        {a3, a2, a1, a0} = 4'b0110;
        #5 `TEST_CASE(out, 2'd2);
        {a3, a2, a1, a0} = 4'b0111;
        #5 `TEST_CASE(out, 2'd2);
        {a3, a2, a1, a0} = 4'b1000;
        #5 `TEST_CASE(out, 2'd3);
        {a3, a2, a1, a0} = 4'b1001;
        #5 `TEST_CASE(out, 2'd3);
        {a3, a2, a1, a0} = 4'b1010;
        #5 `TEST_CASE(out, 2'd3);
        {a3, a2, a1, a0} = 4'b1011;
        #5 `TEST_CASE(out, 2'd3);
        {a3, a2, a1, a0} = 4'b1100;
        #5 `TEST_CASE(out, 2'd3);
        {a3, a2, a1, a0} = 4'b1101;
        #5 `TEST_CASE(out, 2'd3);
        {a3, a2, a1, a0} = 4'b1110;
        #5 `TEST_CASE(out, 2'd3);
        {a3, a2, a1, a0} = 4'b1111;
        #5 `TEST_CASE(out, 2'd3);
        $display("Success!");
        $finish;
    end

endmodule