module Fadd(a,b,cin,cout,sum);
input wire a,b,cin;
output wire cout,sum;

assign cout=(a&b)|(cin&a)|(b&cin);
assign sum=a^b^cin;

endmodule
