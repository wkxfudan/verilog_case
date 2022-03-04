module sync_fifo_tb;

localparam FIFO_WIDTH = 32;
localparam FIFO_DEPTH = 8;
localparam ADDR_WIDTH = 3;

reg                   clk;
reg                   rst_n;
reg                   wr_en;
reg  [FIFO_WIDTH-1:0] wr_data;
reg                   rd_en;
wire                  full;
wire                  wr_err;
wire                  empty;
wire                  rd_err;
wire [FIFO_WIDTH-1:0] rd_data;

integer idx = 0;
integer exp = 0;

`define TEST_CASE(VAR, VALUE) \
    idx = idx + 1; \
    if(VAR == VALUE) $display("Case %d passed!", idx); \
    else begin $display("Case %d failed!", idx); $finish; end 


sync_fifo #(
    .FIFO_WIDTH(FIFO_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .FIFO_DEPTH(FIFO_DEPTH)
) dut (
    .clk(clk),
    .rst_n(rst_n),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .wr_data(wr_data),
    .full(full),
    .wr_err(wr_err),
    .empty(empty),
    .rd_err(rd_err),
    .rd_data(rd_data)
);

initial begin
    clk = 0;
    rst_n = 1'b1;
    rd_en = 1'b0;
    wr_data = 32'b0;
    wr_en = 1'b0;
    #5 rst_n = 1'b0;
    #5 rst_n = 1'b1;
    // #5 wr_en = 1'b1;
    // wr_data = 32'hffff_ffff;
    repeat (10) begin
        #10 wr_en = 1'b1;
        wr_data = wr_data + 1;
        #10 wr_en = 1'b0;
    end
    #50;
    repeat (10) begin
        #10 rd_en = 1'b1;
        #10 rd_en = 1'b0;
        // $display("%d",rd_data);
        exp = idx > 7 ? 0 : idx+1;
        `TEST_CASE(rd_data, exp);
    end
    #50;
    $display("Success!");
    $finish;
end

initial begin
    $dumpvars(0, sync_fifo_tb);
    $dumpfile("a.dump");
end

always #5 begin
    clk <= ~clk;
end

endmodule
