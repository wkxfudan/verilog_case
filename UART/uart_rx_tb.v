module tb_rx;

    reg        clk          ;
    reg        resetn       ;
    reg        uart_rxd     ;

    reg        uart_rx_en   ;
    wire       uart_rx_break;
    wire       uart_rx_valid;
    wire [7:0] uart_rx_data ;

    localparam BIT_RATE = 115200;
    localparam BIT_P    = (1000000000/BIT_RATE);
    localparam CLK_HZ   = 50000000;
    localparam CLK_P    = 1000000000/ CLK_HZ;

    always begin
        #(CLK_P/2) clk    = ~clk;
    end

    task send_byte;
        input [7:0] to_send;
        integer i;
        begin
            #BIT_P;
            uart_rxd = 1'b0;
            for(i=0; i < 8; i = i+1) begin
                #BIT_P;
                uart_rxd = to_send[i];
            end
            #BIT_P;
            uart_rxd = 1'b1;
            #1000;
        end
    endtask

    integer passes = 0;
    integer fails  = 0;
    task check_byte;
        input [7:0] expected_value;
        begin
            if(uart_rx_data == expected_value) begin
                passes = passes + 1;
                $display("%d/%d/%d [PASS] Expected %b and got %b",
                         passes,fails,passes+fails,
                         expected_value, uart_rx_data);
            end
            else begin
                fails  = fails  + 1;
                $display("%d/%d/%d [FAIL] Expected %b and got %b",
                         passes,fails,passes+fails,
                         expected_value, uart_rx_data);
            end
        end
    endtask

    reg [7:0] to_send;
    initial begin
        resetn  = 1'b0;
        clk     = 1'b0;
        uart_rxd = 1'b1;
        #40 resetn = 1'b1;

        $dumpfile("dump.vcd");
        $dumpvars(0,tb_rx);

        uart_rx_en = 1'b1;

        #1000;

        repeat(10) begin
            to_send = $random;
            send_byte(to_send);
            check_byte(to_send);
        end

        $display("BIT RATE      : %db/s", BIT_RATE );
        $display("CLK PERIOD    : %dns" , CLK_P    );
        $display("CYCLES/BIT    : %d"   , i_uart_rx.CYCLES_PER_BIT);
        $display("SAMPLE PERIOD : %d", CLK_P *i_uart_rx.CYCLES_PER_BIT);
        $display("BIT PERIOD    : %dns" , BIT_P    );

        $display("Test Results:");
        $display("    PASSES: %d", passes);
        $display("    FAILS : %d", fails);

        $display("Finish simulation at time %d", $time);
        $finish();
    end


    //
    // Instance of the DUT
    uart_rx #(
                .BIT_RATE(BIT_RATE),
                .CLK_HZ  (CLK_HZ  )
            ) i_uart_rx(
                .clk          (clk          ),
                .resetn       (resetn       ),
                .uart_rxd     (uart_rxd     ),
                .uart_rx_en   (uart_rx_en   ),
                .uart_rx_break(uart_rx_break),
                .uart_rx_valid(uart_rx_valid),
                .uart_rx_data (uart_rx_data )
            );

endmodule
