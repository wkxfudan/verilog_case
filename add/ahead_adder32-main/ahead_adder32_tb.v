`timescale 1ns/1ps


`define TEST_WIDTH 32
module TEST_adder32();

reg clk=1;
reg CIN=0;
wire COUT;
reg [`TEST_WIDTH-1:0] A;
reg [`TEST_WIDTH-1:0] B;

wire [`TEST_WIDTH-1:0] SUM;

reg   [`TEST_WIDTH:0]   sum_ref;


ahead_adder32 U1 (
    .A(A),                            
    .B(B),
    .C_in(CIN),
    .Result(SUM),
    .C_out(COUT)
);

always #1 clk = ~clk;

integer num_good;
integer i;
initial begin
  
    num_good = 0;
    #2

    for(i = 0; i < 32'hFFFF;i=i+1) //随机测试，一一比对所需时间和资源太多
    begin
        A={$random}%(32'hFFFF_FFFF);//
        B={$random}%(32'hFFFF_FFFF);//
        if ({COUT,SUM} !== sum_ref) 
        begin
            $display("failed");
            $finish;
        end        
        else
            num_good = num_good + 1;
        @(posedge clk);
  end		

    $display("success. num good = %d",num_good);
    $finish;

end

always @(posedge clk )
 begin
    sum_ref<=  A+B;
   
end

endmodule

