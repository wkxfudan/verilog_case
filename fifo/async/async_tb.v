module fifo_async_tb;
    reg wclk,wrst_n;
    reg rclk,rrst_n;
    reg wq,rq;
    reg [7:0] write_data;             // data input to be pushed to buffer
    wire [7:0] read_data;       // port to output the data using pop.
    wire rempty,wfull;  // buffer empty and full indication

    integer idx = 0;

    `define TEST_CASE(VAR, VALUE) \
    idx = idx + 1; \
    if(VAR == VALUE) $display("Case %d passed!", idx); \
    else begin $display("Case %d failed!", idx); $finish; end 

fifo_async   #(.DSIZE(8), .ASIZE(4)) fifo_inst(
	.rclk(rclk),.rrst_n(rrst_n),.rq(rq),
	.wclk(wclk),.wrst_n(wrst_n),.wq(wq),
	.write_data(write_data),.read_data(read_data),
	.wfull(wfull),.rempty(rempty));

always #10 wclk = ~wclk;
always #20 rclk = ~rclk;

reg [7:0] tempdata = 0;
    initial begin
	    rclk = 0;
	    wclk = 0;
    end
    initial begin
	    wrst_n = 1;
	    #2;
	    wrst_n = 0;
	    #60;
	    wrst_n = 1;
    end

    initial begin
	    rrst_n = 1;
	    #2;
	    rrst_n = 0;
	    #120;
	    rrst_n = 1;
    end
    always  @(posedge wclk or negedge wrst_n)
    begin
	    if(wrst_n==1'b0)
	    begin
		    wq <= 0;
		    rq <= 0;
	    end
	    else begin
		    wq <= ~wq;
	    end
    end

    always  @(posedge rclk or negedge rrst_n)
    if(rrst_n==1'b0)
	    rq <= 0;
    else
	    rq <= ~rq;

    initial write_data = 0;

    always #5 write_data <= write_data + 1;

   initial
   begin
     $dumpfile("dump.vcd");
     $dumpvars;
   end

   initial begin
        #110 $display("%d",read_data);`TEST_CASE(read_data, 8'h11);
        # 90 `TEST_CASE(read_data, 8'h19);
        # 90 `TEST_CASE(read_data, 8'h21);
        # 90 `TEST_CASE(read_data, 8'h29);
        # 90 `TEST_CASE(read_data, 8'h31);
        # 90 `TEST_CASE(read_data, 8'h39);
        # 90 `TEST_CASE(read_data, 8'h41);
        # 90 `TEST_CASE(read_data, 8'h49);
        $display("Success!");
        $finish;
   end

endmodule