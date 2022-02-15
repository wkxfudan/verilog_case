module comp_n_tb;

    reg a_1;
    reg b_1;
    reg [31:0] a_32;
    reg [31:0] b_32;
    wire lt_1;
    wire gt_1;
    wire eq_1;
    wire lt_32;
    wire gt_32;
    wire eq_32;
    wire [2:0] res_1; 
    wire [2:0] res_32;

    assign res_1 = {lt_1, eq_1, gt_1};
    assign res_32 = {lt_32, eq_32, gt_32};

    integer idx = 0;

    `define TEST_CASE(VAR, VALUE) \
        idx = idx + 1; \
        if(VAR == VALUE) $display("Case %d passed!", idx); \
        else begin $display("Case %d failed!", idx); $finish; end 

    comp_n #(.DW(1)) dut_1 
    (
        .a(a_1),
        .b(b_1),
        .lt(lt_1),
        .gt(gt_1),
        .eq(eq_1)
    );

    comp_n #(.DW(32)) dut_32 (
        .a(a_32),
        .b(b_32),
        .lt(lt_32),
        .gt(gt_32),
        .eq(eq_32)
    );

    initial begin
        a_1 = 1'b0;     b_1 = 1'b0;
        #5 `TEST_CASE (res_1, 3'b010);
        a_1 = 1'b0;     b_1 = 1'b1;
        #5 `TEST_CASE (res_1, 3'b100);
        a_1 = 1'b1;     b_1 = 1'b0;
        #5 `TEST_CASE (res_1, 3'b001);
        a_1 = 1'b1;     b_1 = 1'b1;
        #5 `TEST_CASE (res_1, 3'b010);
        a_32 = 32'h4afd5b6c;  b_32 = 32'hf74a32ab;
        #5 `TEST_CASE (res_32, 3'b100);
        a_32 = 32'h325b63ff;  b_32 = 32'h325b63ff;
        #5 `TEST_CASE (res_32, 3'b010);
        a_32 = 32'hffffffff;  b_32 = 32'h00000000;
        #5 `TEST_CASE (res_32, 3'b001);
        a_32 = 32'h445832a3;  b_32 = 32'h446058b3;
        #5 `TEST_CASE (res_32, 3'b100);
        $display("Success!");
        $finish;
    end

endmodule