module three_inputs_gate (
    a,b,c,out
);
    input wire a;
    input wire b;
    input wire c;
    output wire out;

    assign out = a | b |c;
    
endmodule