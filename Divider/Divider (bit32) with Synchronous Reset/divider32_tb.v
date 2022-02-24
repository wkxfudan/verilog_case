`timescale 1ns / 1ps

// Simulation Time: 1610ns
module divider32_tb;

	// Inputs
	reg clk;
	reg sync_rst;
	reg valid;
	reg signed [31:0] DIVIDEND;
	reg signed [31:0] DIVISOR;

	// Outputs
	wire [31:0] Q;
	wire [31:0] R;
	wire ready;

	// Instantiate the Unit Under Test (UUT)
	divider32 uut 
		(
			.clk(clk), 
			.sync_rst(sync_rst), 
			.valid(valid), 
			.DIVIDEND(DIVIDEND), 
			.DIVISOR(DIVISOR), 
			.Q(Q), 
			.R(R), 
			.ready(ready)
		);

	// Initialize Inputs
	initial 
		fork
			clk = 0;
			sync_rst = 0;
			valid = 0;
			DIVIDEND = 0;
			DIVISOR = 0;
			
			#4 sync_rst=1;
			#9 sync_rst=0;

			#9 DIVIDEND=32'b00100110_10100101_01010001_01011101;
			#9 DIVISOR=32'b00000000_00001110_10001001_01011010;
			#9 valid=1;
			#19 valid=0;

			#404 DIVIDEND=32'b11010101_01010100_01110101_01100010;
			#404 DIVISOR=32'b00000000_00000100_00110101_11001010;
			#404 valid=1;
			#414 valid=0;

			#804 DIVIDEND=32'b01000100_10110111_01001001_01011010;
			#804 DIVISOR=32'b11111111_11111111_11010011_01100010;
			#804 valid=1;
			#814 valid=0;

			#1204 DIVIDEND=32'b11010001_11010101_01001101_00011101;
			#1204 DIVISOR=32'b11111111_11111110_00100101_11101010;
			#1204 valid=1;
			#1214 valid=0;

			#1610 $stop;
		join

	always #5 clk=~clk;

	// Auto check
	reg [31:0] Q_ref;
	reg [31:0] R_ref;
	initial
		fork
			Q_ref=0;
			R_ref=0;
			#5 Q_ref=32'b00000010_10101000;
			#5 R_ref=32'b00001000_01111010_01001101;
			#405 Q_ref=32'b11111111_11111111_11110101_11011110;
			#405 R_ref=32'b11111111_11111101_01111110_00110110;
			#805 Q_ref=32'b11111111_11111110_01110101_10111011;
			#805 R_ref=32'b00000000_00000000_00010110_11000100;
			#1205 Q_ref=32'b00000000_00000000_00011000_11101101;
			#1205 R_ref=32'b11111111_11111110_01000011_01111011;
		join
	
	reg [1:0] count;
	initial count=2'b00;
	always #400 count<=count+2'b01;

	reg fail;
	initial fail=0;
	always #400
		if((Q==Q_ref)&&(R==R_ref))
			fork
				$display("%ds: passed",400*(count+1));
				fail<=fail;
			join
		else
			fork
				$display("%ds: something wrong!",400*(count+1));
				fail<=1;
			join
	initial #1605
		if(fail)
			$display("SIMULATION FAILED!");
		else
			$display("SIMULATION SUCCEEDED!");	
endmodule

