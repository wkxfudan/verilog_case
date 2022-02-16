module four_inputs_gate (
   a,b,c,d,out
);
   input wire a;
   input wire b;
   input wire c;
   input wire d;
   output wire out;

   assign out= (~b & ~c) | (~a & ~d) | (b & c & d) |(a & ~b & d);

endmodule