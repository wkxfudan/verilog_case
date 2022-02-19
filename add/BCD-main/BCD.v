module BCD(input[3:0] a,
input[3:0] b,
input cin,
output reg [3:0] sum,
output reg cout

    );
    reg [4:0] temp;
    always@(*)
begin
    temp<=a+b+cin;
    if(temp>4'b1001)
        begin
    cout<=1;
    sum<=temp+4'b0110;
        end
    else 
        begin
    cout<=0;
    sum<=temp;
        end
end
    
    
    
    
    
endmodule
