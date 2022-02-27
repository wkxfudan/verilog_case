`timescale 1ns / 1ps

// Simulation time: 810s
module booth_multiplier32_tb;

	// Inputs
	reg clk;
	reg async_rst;
	reg valid;
	reg signed [31:0] A;
	reg signed [31:0] B;
	reg [30:0] A_data;
	reg [30:0] B_data;

	// Outputs
	wire [63:0] R;
	wire ready;

	// Instantiate the Unit Under Test (UUT)
	booth_multiplier32 uut 
		(
			.clk(clk), 
			.async_rst(async_rst), 
			.valid(valid), 
			.A(A), 
			.B(B), 
			.R(R), 
			.ready(ready)
		);

	// Initial signals
	initial
		fork
			clk=0;
			async_rst=0;
			valid=0;
			A=0;
			B=0;
			#1 async_rst=1;
			#3 async_rst=0;
			#3 A_data={$random}%(2**31);
			#4 A={1'b0,A_data};
			#3 B_data={$random}%(2**31);
			#4 B={1'b0,B_data};
			#4 valid=1;
			#9 valid=0;
			#203 A_data={$random}%(2**31);
			#204 A={1'b0,A_data};
			#203 B_data={$random}%(2**31);
			#204 B={1'b1,B_data};
			#204 valid=1;
			#209 valid=0;
			#403 A_data={$random}%(2**31);
			#404 A={1'b1,A_data};
			#403 B_data={$random}%(2**31);
			#404 B={1'b0,B_data};
			#404 valid=1;
			#409 valid=0;
			#603 A_data={$random}%(2**31);
			#604 A={1'b1,A_data};
			#603 B_data={$random}%(2**31);
			#604 B={1'b1,B_data};
			#604 valid=1;
			#609 valid=0;
			#810 $finish;
		join

	// Clock signal
	always #5 clk=~clk;
	
	// Auto check
	wire signed [63:0] Mul;
    assign Mul=A*B;

	integer cycle;
	initial cycle=1;
	always #200
		cycle<=cycle+1;

	reg result;
	initial 
		begin
			result=1;
			#805;
			if(result)
				$display("SIMULATION SUCCEEDED!");
			else	
				$display("SIMULATION FAILED!");
		end
	always #200
		if(Mul==R)
			$display("%ds: passed!",200*cycle);
		else
			fork
				$display("%ds: Something wrong!",200*cycle);
				result=0;
			join
endmodule

