module TEST_BCD(

    );
    reg [3:0] A;
    reg [3:0] B;
    reg CIN;
    wire [3:0]SUM;
    wire COUT;
    integer i;
    reg clk=1;
    reg [4:0] temp;
    reg [4:0] sum_ref;
    reg[31:0] num_good=0;
BCD U1(.a(A),
.b(B),
.cin(CIN),
.sum(SUM),
.cout(COUT));

    always #1 clk=~clk;
    
    initial 
    begin
   
  
    for(i=0;i<99;i=1+1)
   
    begin
    #2;
    CIN={$random}%2;
    A={$random}%(4'b1010);
    B={$random}%(4'b1010);
    if({COUT,SUM}!=sum_ref)
    begin
    $display("failed");
    $finish;
    end
    else 
    num_good=num_good+1;
    #2;
    end
    
    $display ("success");
    $finish;
    end
    
    always@(posedge clk)
    begin
    temp<=A+B+CIN;
    if(temp>4'b1001)
    sum_ref<=temp+4'b0110;
    else 
    sum_ref<=temp;
    end
    
   
    
    
    
    
    
    
    
endmodule
