module mux_9
    #(
         parameter DW = 1
     )
     (
         input  wire [DW-1:0] a,
         input  wire [DW-1:0] b,
         input  wire [DW-1:0] c,
         input  wire [DW-1:0] d,
         input  wire [DW-1:0] e,
         input  wire [DW-1:0] f,
         input  wire [DW-1:0] g,
         input  wire [DW-1:0] h,
         input  wire [DW-1:0] i,
         input  wire [   3:0] sel,
         output reg  [DW-1:0] out
     );

    always @(*) begin
        case (sel)
            4'h0:
                out = a;
            4'h1:
                out = b;
            4'h2:
                out = c;
            4'h3:
                out = d;
            4'h4:
                out = e;
            4'h5:
                out = f;
            4'h6:
                out = g;
            4'h7:
                out = h;
            4'h8:
                out = i;
            default:
                out = {DW{1'b1}};
        endcase
    end

endmodule
