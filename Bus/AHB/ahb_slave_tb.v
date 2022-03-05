module ahb_slave_tb;

    reg          HRESETn;
    reg          HCLK;
    reg          HSEL;
    reg   [31:0] HADDR;
    reg   [ 1:0] HTRANS;
    reg          HWRITE;
    reg   [ 2:0] HSIZE;
    reg   [ 2:0] HBURST;
    reg   [31:0] HWDATA;
    wire  [31:0] HRDATA;
    wire  [ 1:0] HRESP;
    reg          HREADYin;
    wire         HREADYout;

    integer idx = 0;

    `define TEST_CASE(VAR, VALUE) \
    idx = idx + 1; \
    if(VAR == VALUE) $display("Case %d passed!", idx); \
    else begin $display("Case %d failed!", idx); $finish; end 


    ahb_slave dut
    (
        .HRESETn(HRESETn),
        .HCLK(HCLK),
        .HSEL(HSEL),
        .HADDR(HADDR),
        .HTRANS(HTRANS),
        .HWRITE(HWRITE),
        .HSIZE(HSIZE),
        .HBURST(HBURST),
        .HWDATA(HWDATA),
        .HRDATA(HRDATA),
        .HRESP(HRESP),
        .HREADYin(HREADYin),
        .HREADYout(HREADYout)
    );

    initial begin
        HCLK = 0;
        HRESETn = 1;
        HSEL = 1;
        HADDR = 32'b0;
        HTRANS = 2'b0;
        HWRITE = 0;
        HSIZE = 3'b0;
        HBURST = 0;
        HWDATA = 32'b0;
        HREADYin = 1'b1;

        #10
        HRESETn = 0;
        #5 HRESETn = 1;

        #10 HTRANS = 2'b00;
        #5 `TEST_CASE(HRESP, 2'b00);

        #10 HSEL = 0;

        #30 HTRANS = 2'b01;
        HSEL = 1;
        #5 `TEST_CASE(HRESP, 2'b00);

        #30 HTRANS = 2'b11;

        #5 `TEST_CASE(HRESP, 2'b01);

        #10 $finish;

        $display("Success!");
        
    end

    // initial begin
    //     $dumpvars(0, ahb_slave_tb);
    //     $dumpfile("dump.vcd");
    // end

    always #5 HCLK = ~HCLK;

endmodule