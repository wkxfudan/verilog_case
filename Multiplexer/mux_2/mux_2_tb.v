module mux_2_tb;

    reg [31:0] a;
    reg [31:0] b;
    reg sel;
    wire [31:0] out;

    integer idx = 0;

    `define TEST_CASE(VAR, VALUE) \
        idx = idx + 1; \
        if(VAR == VALUE) $display("Case %d passed!", idx); \
        else begin $display("Case %d failed!", idx); $finish; end 

    mux_2 #(.DW(32)) dut
    (
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );

    initial begin
        a = 32'hffffffff;
        b = 32'h00000000;
        sel = 0;
        #5 `TEST_CASE(out, 32'hffffffff);
        sel = 1;
        #5 `TEST_CASE(out, 32'h00000000);
        $display("Success!");
        $finish;
    end

endmodule