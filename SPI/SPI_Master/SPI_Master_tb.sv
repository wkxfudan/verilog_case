///////////////////////////////////////////////////////////////////////////////
// Description:       Simple test bench for SPI Master module
///////////////////////////////////////////////////////////////////////////////


module SPI_Master_TB ();

    parameter SPI_MODE = 3; // CPOL = 1, CPHA = 1
    parameter CLKS_PER_HALF_BIT = 4;  // 6.25 MHz
    parameter MAIN_CLK_DELAY = 2;  // 25 MHz

    logic r_Rst_L     = 1'b0;
    logic w_SPI_Clk;
    logic r_Clk       = 1'b0;
    logic w_SPI_MOSI;

    // Master Specific
    logic [7:0] r_Master_TX_Byte = 0;
    logic r_Master_TX_DV = 1'b0;
    logic w_Master_TX_Ready;
    logic r_Master_RX_DV;
    logic [7:0] r_Master_RX_Byte;

    // Clock Generators:
    always #(MAIN_CLK_DELAY) r_Clk = ~r_Clk;

    // Instantiate UUT
    SPI_Master
        #(.SPI_MODE(SPI_MODE),
          .CLKS_PER_HALF_BIT(CLKS_PER_HALF_BIT)) SPI_Master_UUT
        (
            // Control/Data Signals,
            .i_Rst_L(r_Rst_L),     // FPGA Reset
            .i_Clk(r_Clk),         // FPGA Clock

            // TX (MOSI) Signals
            .i_TX_Byte(r_Master_TX_Byte),     // Byte to transmit on MOSI
            .i_TX_DV(r_Master_TX_DV),         // Data Valid Pulse with i_TX_Byte
            .o_TX_Ready(w_Master_TX_Ready),   // Transmit Ready for Byte

            // RX (MISO) Signals
            .o_RX_DV(r_Master_RX_DV),       // Data Valid pulse (1 clock cycle)
            .o_RX_Byte(r_Master_RX_Byte),   // Byte received on MISO

            // SPI Interface
            .o_SPI_Clk(w_SPI_Clk),
            .i_SPI_MISO(w_SPI_MOSI),
            .o_SPI_MOSI(w_SPI_MOSI)
        );


    // Sends a single byte from master.
    task SendSingleByte(input [7:0] data);
        @(posedge r_Clk);
        r_Master_TX_Byte <= data;
        r_Master_TX_DV   <= 1'b1;
        @(posedge r_Clk);
        r_Master_TX_DV <= 1'b0;
        @(posedge w_Master_TX_Ready);
    endtask // SendSingleByte


    initial begin
        repeat(10) @(posedge r_Clk);
        r_Rst_L  = 1'b0;
        repeat(10) @(posedge r_Clk);
        r_Rst_L          = 1'b1;

        // Test single byte
        SendSingleByte(8'hC1);
        $display("Sent out 0xC1, Received 0x%X", r_Master_RX_Byte);

        // Test double byte
        SendSingleByte(8'hBE);
        $display("Sent out 0xBE, Received 0x%X", r_Master_RX_Byte);
        SendSingleByte(8'hEF);
        $display("Sent out 0xEF, Received 0x%X", r_Master_RX_Byte);
        repeat(10) @(posedge r_Clk);
        $display("Success!");
        $finish();
    end // initial begin

endmodule // SPI_Slave
