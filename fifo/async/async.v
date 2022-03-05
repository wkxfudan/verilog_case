module fifo_async (read_data, wfull, rempty, write_data,
	wq, wclk, wrst_n, rq, rclk, rrst_n);
parameter DSIZE = 8;
parameter ASIZE = 4;
output [DSIZE-1:0] read_data;
output wfull;
output rempty;
input [DSIZE-1:0] write_data;
input wq, wclk, wrst_n;
input rq, rclk, rrst_n;
wire [ASIZE-1:0] wptr, rptr;
wire [ASIZE-1:0] waddr, raddr;
async_cmp #(ASIZE) async_cmp(.aempty_n(aempty_n),
	.afull_n(afull_n),
	.wptr(wptr), .rptr(rptr),
	.wrst_n(wrst_n));
fifomem2 #(DSIZE, ASIZE) fifomem2(.read_data(read_data),
	.write_data(write_data),
	.waddr(wptr),
	.raddr(rptr),
	.wq(wq),
	.wclk(wclk));
rptr_empty2 #(ASIZE) rptr_empty2(.rempty(rempty),
	.rptr(rptr),
	.aempty_n(aempty_n),
	.rq(rq),
	.rclk(rclk),
	.rrst_n(rrst_n));
wptr_full2 #(ASIZE) wptr_full2(.wfull(wfull),
	.wptr(wptr),
	.afull_n(afull_n),
	.wq(wq),
	.wclk(wclk),
	.wrst_n(wrst_n));
endmodule

module fifomem2
#(
    parameter  DATASIZE = 8, // Memory data word width
    parameter  ADDRSIZE = 4  // depth is 2^(ADDRSIZE-1),extra one bit is to judge empty or full
) // Number of mem address bits
(
    output [DATASIZE-1:0] read_data,
    input  [DATASIZE-1:0] write_data,
    input  [ADDRSIZE-1:0] waddr, raddr,
    input                 wq, wclk
);
   localparam DEPTH = 1<<ADDRSIZE; // DEPTH = 2**ADDRSIZE
   reg [DATASIZE-1:0] MEM [0:DEPTH-1];
   assign read_data = MEM[raddr];
   always @(posedge wclk)
	if (wq)
	  MEM[waddr] <= write_data;
endmodule

module async_cmp
#(
    parameter  ADDRSIZE = 4  // depth is 2^(ADDRSIZE-1),extra one bit is to judge empty or full
)
(
        input [ADDRSIZE-1:0]	wptr, rptr,
       	input wrst_n,
	output aempty_n, afull_n
);

localparam N = ADDRSIZE-1;
//internal signals
reg direction;
wire high = 1'b1;
wire dirset_n = ~( (wptr[N]^rptr[N-1]) & ~(wptr[N-1]^rptr[N]));
wire dirclr_n = ~((~(wptr[N]^rptr[N-1]) & (wptr[N-1]^rptr[N]))|	~wrst_n);
always @(posedge high or negedge dirset_n or negedge dirclr_n)
	if (!dirclr_n)
	  direction <= 1'b0;
	else if(!dirset_n)
	  direction <= 1'b1;
	else
	  direction <= high;
assign aempty_n = ~((wptr == rptr) && !direction);
assign afull_n = ~((wptr == rptr) && direction);

endmodule

module rptr_empty2
#(
    parameter  ADDRSIZE = 4  // depth is 2^(ADDRSIZE-1),extra one bit is to judge empty or full
)
(
	input aempty_n,
	input rq,rclk,rrst_n,
	output reg rempty,
	output reg [ADDRSIZE-1:0] rptr
);
reg [ADDRSIZE-1:0] rbin;
reg rempty2;
wire [ADDRSIZE-1:0] rgnext, rbnext;
//---------------------------------------------------------------
// GRAYSTYLE2 pointer
//---------------------------------------------------------------
always @(posedge rclk or negedge rrst_n)
     if (!rrst_n)
     begin
	     rbin <= 0;
	     rptr <= 0;
     end
     else
     begin
	     rbin <= rbnext;
	     rptr <= rgnext;
     end
	//---------------------------------------------------------------
	// increment the binary count if not empty
		//---------------------------------------------------------------
assign rbnext = !rempty ? rbin + rq : rbin;
assign rgnext = (rbnext>>1) ^ rbnext; // binary-to-gray conversion
always @(posedge rclk or negedge aempty_n)
	if (!aempty_n) {rempty,rempty2} <= 2'b11;
	else {rempty,rempty2} <= {rempty2,~aempty_n};
endmodule

module wptr_full2
#(
    parameter  ADDRSIZE = 4  // depth is 2^(ADDRSIZE-1),extra one bit is to judge empty or full
)
(
	input afull_n, wq, wclk,wrst_n,
	output reg wfull,
	output reg [ADDRSIZE-1:0] wptr
);

reg [ADDRSIZE-1:0] wbin;
reg  wfull2;
wire [ADDRSIZE-1:0] wgnext, wbnext;
//---------------------------------------------------------------
// GRAYSTYLE2 pointer
//---------------------------------------------------------------
always @(posedge wclk or negedge wrst_n)
	if (!wrst_n) begin
		wbin <= 0;
		wptr <= 0;
	end
	else begin
		wbin <= wbnext;
		wptr <= wgnext;
	end
	//---------------------------------------------------------------
	// increment the binary count if not full
assign wbnext = !wfull ? wbin + wq : wbin;
assign wgnext = (wbnext>>1) ^ wbnext; // binary-to-gray conversion
always @(posedge wclk or negedge wrst_n or negedge afull_n)
	if (!wrst_n ) {wfull,wfull2} <= 2'b00;
	else if (!afull_n) {wfull,wfull2} <= 2'b11;
	else {wfull,wfull2} <= {wfull2,~afull_n};
endmodule