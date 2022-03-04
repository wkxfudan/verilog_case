module sync_fifo
#(
    parameter FIFO_WIDTH = 32,
    parameter ADDR_WIDTH = 3,
    parameter FIFO_DEPTH = 8
)
(
    input  wire                  clk,
    input  wire                  rst_n,

    input  wire                  wr_en,
    input  wire [FIFO_WIDTH-1:0] wr_data,
    input  wire                  rd_en,
    
    output wire                  full,
    output wire                  wr_err,
    output wire                  empty,
    output wire                  rd_err,
    output reg  [FIFO_WIDTH-1:0] rd_data
);

    reg  [  ADDR_WIDTH:0] fifo_cnt; // Here need extra 1bit for full
    reg  [FIFO_WIDTH-1:0] fifo_mem [0:FIFO_DEPTH-1];
    reg  [ADDR_WIDTH-1:0] rd_ptr;
    reg  [ADDR_WIDTH-1:0] wr_ptr;
    
    wire wr_vali;       // HIGH when wr_en && ~full
    wire rd_vali;       // HIGH when rd_en && ~empty

    assign wr_vali = ~full & wr_en;
    assign rd_vali = ~empty & rd_en;

    integer _idx;

    // fifo counter value
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            fifo_cnt <= 0;
        end else begin
            case({wr_vali, rd_vali})
                2'b01: 
                    fifo_cnt <= fifo_cnt - 1'b1;
                2'b10: 
                    fifo_cnt <= fifo_cnt + 1'b1;
                default:
                    fifo_cnt <= fifo_cnt;
            endcase
        end
    end

    // read data if rd_vali is HIGH
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            rd_data <= 0;
        end else begin
            rd_data <= rd_vali ? fifo_mem[rd_ptr] : 0;
        end
    end

    // write data if wr_vali is HIGH
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            for (_idx = 0; _idx < FIFO_DEPTH; _idx = _idx + 1) begin
                fifo_mem[_idx] <= 0;
            end
        end else begin
            fifo_mem[wr_ptr] <= wr_vali ? wr_data : fifo_mem[wr_ptr];
        end
    end

    // update read and write pointer
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
        end else begin
            wr_ptr <= wr_en ? ((wr_ptr == FIFO_DEPTH - 1) ? 0 : wr_ptr + 1) : wr_ptr;
            rd_ptr <= rd_en ? ((rd_ptr == FIFO_DEPTH - 1) ? 0 : rd_ptr + 1) : rd_ptr;
        end
    end

    assign full   = (fifo_cnt == FIFO_DEPTH);
    assign empty  = ~(|fifo_cnt);
    assign wr_err = wr_en & full;
    assign rd_err = rd_en & empty;

endmodule
