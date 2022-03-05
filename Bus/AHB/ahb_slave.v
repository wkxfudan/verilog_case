module ahb_slave (
       input   wire         HRESETn,
       input   wire         HCLK,
       input   wire         HSEL,
       input   wire  [31:0] HADDR,
       input   wire  [ 1:0] HTRANS,
       input   wire         HWRITE,
       input   wire  [ 2:0] HSIZE,
       input   wire  [ 2:0] HBURST,
       input   wire  [31:0] HWDATA,
       output  wire  [31:0] HRDATA,
       output  reg   [ 1:0] HRESP,
       input   wire         HREADYin,
       output  reg          HREADYout
);
   /*********************************************************/
   assign HRDATA = 32'h0;
   /*********************************************************/
       reg [1:0] state;
       localparam STH_IDLE   = 2'h0,
                  STH_WRITE  = 2'h1,
                  STH_READ0  = 2'h2;
   /*********************************************************/
   always @ (posedge HCLK or negedge HRESETn) begin
       if (HRESETn==0) begin
           HRESP     <= 2'b00; //`HRESP_OKAY;
           HREADYout <= 1'b1;
           state     <= STH_IDLE;
       end else begin // if (HRESETn==0) begin
           case (state)
           STH_IDLE: begin
                if (HSEL && HREADYin) begin
                   case (HTRANS)
                   //`HTRANS_IDLE, `HTRANS_BUSY: begin
                   2'b00, 2'b01: begin
                          HREADYout <= 1'b1;
                          HRESP     <= 2'b00; //`HRESP_OKAY;
                          state     <= STH_IDLE;
                    end // HTRANS_IDLE or HTRANS_BUSY
                   //`HTRANS_NONSEQ, `HTRANS_SEQ: begin
                   2'b10, 2'b11: begin
                          HREADYout <= 1'b0;
                          HRESP     <= 2'b01; //`HRESP_ERROR;
                          if (HWRITE) begin
                              state <= STH_WRITE;
                          end else begin
                              state <= STH_READ0;
                          end
                    end // HTRANS_NONSEQ or HTRANS_SEQ
                   endcase // HTRANS
                end else begin// if (HSEL && HREADYin)
                    HREADYout <= 1'b1;
                    HRESP     <= 2'b00; //`HRESP_OKAY;
                end
                end // STH_IDLE
           STH_WRITE: begin
                     HREADYout <= 1'b1;
                     HRESP     <= 2'b01; //`HRESP_ERROR;
                     state     <= STH_IDLE;
                end // STH_WRITE
           STH_READ0: begin
                    HREADYout <= 1'b1;
                    HRESP     <= 2'b01; //`HRESP_ERROR;
                    state     <= STH_IDLE;
                end // STH_READ0
           endcase // state
       end // if (HRESETn==0)
   end // always

endmodule