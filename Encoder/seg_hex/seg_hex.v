module seg_hex (
    input  wire [7:0] seg,
    output reg  [3:0] hex,
    output wire       dp
);

    assign dp = seg[7];
    always @(*) begin
        case(seg[6:0])
            7'h3f: hex = 4'h0;
            7'h06: hex = 4'h1;
            7'h5b: hex = 4'h2;
            7'h4f: hex = 4'h3;
            7'h66: hex = 4'h4;
            7'h6d: hex = 4'h5;
            7'h7d: hex = 4'h6;
            7'h07: hex = 4'h7;
            7'h7f: hex = 4'h8;
            7'h6f: hex = 4'h9;
            7'h77: hex = 4'ha;
            7'h7c: hex = 4'hb;
            7'h39: hex = 4'hc;
            7'h5e: hex = 4'hd;
            7'h79: hex = 4'he;
            7'h71: hex = 4'hf;
            default: hex = 4'h0;
        endcase
    end

endmodule