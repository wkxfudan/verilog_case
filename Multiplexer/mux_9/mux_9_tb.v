module mux_9_tb;

    reg [31:0] a;
    reg [31:0] b;
    reg [31:0] c;
    reg [31:0] d;
    reg [31:0] e;
    reg [31:0] f;
    reg [31:0] g;
    reg [31:0] h;
    reg [31:0] i;
    reg [3:0] sel;
    wire [31:0] out;

    integer idx = 0;

    `define TEST_CASE(VAR, VALUE) \
        idx = idx + 1; \
        if(VAR == VALUE) $display("Case %d passed!", idx); \
        else begin $display("Case %d failed!", idx); $finish; end 

    mux_9 #(.DW(32)) dut
    (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .e(e),
        .f(f),
        .g(g),
        .h(h),
        .i(i),
        .sel(sel),
        .out(out)
    );

    initial begin
        a = 32'h00000000;
        b = 32'h11111111;
        c = 32'h22222222;
        d = 32'h33333333;
        e = 32'h44444444;
        f = 32'h55555555;
        g = 32'h66666666;
        h = 32'h77777777;
        i = 32'h88888888;
        sel = 4'd0;
        #5 `TEST_CASE(out, 32'h00000000);
        sel = 4'd1;
        #5 `TEST_CASE(out, 32'h11111111);
        sel = 4'd2;
        #5 `TEST_CASE(out, 32'h22222222);
        sel = 4'd3;
        #5 `TEST_CASE(out, 32'h33333333);
        sel = 4'd4;
        #5 `TEST_CASE(out, 32'h44444444);
        sel = 4'd5;
        #5 `TEST_CASE(out, 32'h55555555);
        sel = 4'd6;
        #5 `TEST_CASE(out, 32'h66666666);
        sel = 4'd7;
        #5 `TEST_CASE(out, 32'h77777777);
        sel = 4'd8;
        #5 `TEST_CASE(out, 32'h88888888);
        a = 32'h13fb6d59;
        b = 32'h8f9e3325;
        c = 32'hff9c3271;
        d = 32'h9c8b2572;
        e = 32'h8c5b3d22;
        f = 32'hbc720dcd;
        g = 32'h7c5bc903;
        h = 32'h13c33211;
        i = 32'hac0913b2;
        sel = 4'd0;
        #5 `TEST_CASE(out, 32'h13fb6d59);
        sel = 4'd1;
        #5 `TEST_CASE(out, 32'h8f9e3325);
        sel = 4'd2;
        #5 `TEST_CASE(out, 32'hff9c3271);
        sel = 4'd3;
        #5 `TEST_CASE(out, 32'h9c8b2572);
        sel = 4'd4;
        #5 `TEST_CASE(out, 32'h8c5b3d22);
        sel = 4'd5;
        #5 `TEST_CASE(out, 32'hbc720dcd);
        sel = 4'd6;
        #5 `TEST_CASE(out, 32'h7c5bc903);
        sel = 4'd7;
        #5 `TEST_CASE(out, 32'h13c33211);
        sel = 4'd8;
        #5 `TEST_CASE(out, 32'hac0913b2);
        sel = 4'd9;
        #5 `TEST_CASE(out, 32'hffffffff);
        sel = 4'd15;
        #5 `TEST_CASE(out, 32'hffffffff);
        $display("Success!");
        $finish;
    end

endmodule