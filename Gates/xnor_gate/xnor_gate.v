module xnor_gate (
    a,b,out
);
    input wire a;
    input wire b;
    output wire out;
    assign out=~(a^b);
    
endmodule