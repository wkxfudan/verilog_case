
module hadd(a,b,cout,sum

    );
    input wire a,b;
    output wire cout,sum;
    assign cout=a&b;
    assign sum=a^b;
    
endmodule
