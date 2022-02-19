module testbench_Fadd(

    );
    reg a,b,cin;
    wire cout,sum;
    integer i=0;
    `define test_fadd(A,B,CIN,COUT,SUM)\
    a=A;\
    b=B;\
    cin=CIN;\
    i=i+1;\
    #5;\
    if(COUT==cout&&SUM==sum)\
    $display ("case %d passed!",i);\
    else begin\
    $display("case %d failed!",i);\
    $finish;\
    end;\
    
 Fadd U1(.a(a),
 .b(b),
 .cin(cin),
 .cout(cout),
 .sum(sum));
 
 initial
 begin
 `test_fadd(0,0,0,0,0);
 `test_fadd(0,0,1,0,1);
 `test_fadd(0,1,0,0,1);
 `test_fadd(0,1,1,1,0);
 `test_fadd(1,0,0,0,1);
 `test_fadd(1,0,1,1,0);
 `test_fadd(1,1,0,1,0);
 `test_fadd(1,1,1,1,1);

 $display ("success!");
 $finish;
end     
endmodule
