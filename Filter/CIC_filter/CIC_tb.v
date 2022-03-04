module test ;
    parameter    NIN  = 12 ;
    parameter    NMAX = 21 ;
    parameter    NOUT = NMAX ;

    reg                  clk ;
    reg                  rstn ;
    reg                  en ;
    reg  [NIN-1:0]       din ;
    wire                 valid ;
    wire [NOUT-1:0]      dout ;

    //=====================================
    // 50MHz clk generating
    localparam   T50M_HALF    = 10000;
    initial begin
        clk = 1'b0 ;
        forever begin
            # T50M_HALF clk = ~clk ;
        end
    end

    //============================
    //  reset and finish
    initial begin
        rstn = 1'b0 ;
        # 30 ;
        rstn = 1'b1 ;
        # (T50M_HALF * 2 * 2000) ;
        $finish ;
    end

    //=======================================
    // read cos data into register
    parameter    SIN_DATA_NUM = 200 ;
    reg          [NIN-1:0] stimulus [0: SIN_DATA_NUM-1] ;
    integer      i ;
    initial begin
        $readmemh("cosx0p25m7p5m12bit.txt", stimulus) ;
        i         = 0 ;
        en        = 0 ;
        din       = 0 ;
        # 200 ;
        forever begin
            @(negedge clk) begin
                en          = 1 ;
                din         = stimulus[i] ;
                if (i == SIN_DATA_NUM-1) begin
                    i = 0 ;
                end
                else begin
                    i = i + 1 ;
                end
            end
        end
    end

    cic #(.NIN(NIN), .NMAX(NMAX), .NOUT(NOUT))
    u_cic (
     .clk         (clk),
     .rstn        (rstn),
     .en          (en),
     .din         (din),
     .valid       (valid),
     .dout        (dout));

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
    end

endmodule // test