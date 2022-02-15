`timescale 1ns/1ps

module left_rotate_reg
    #(parameter DW=4)
    (
        input wire clk,
        input wire async_rst,
        input wire load,
        input wire en,
        input wire [DW-1:0] data,
        output reg [DW-1:0] q
    );

    // bit 0
    always @(posedge clk or posedge async_rst)
        if(async_rst)
            q[0]<=0;
        else
            q[0]<=load&data[0]|(~load)&en&q[DW-1]|(~load)&(~en)&q[0];

    // bit [DW-1:1]
    genvar i;
    generate
        for(i=1;i<DW;i=i+1)
            begin:dff_array
                always @(posedge clk or posedge async_rst)
                    if(async_rst)
                        q[i]<=0;
                    else 
                        q[i]<=load&data[i]|(~load)&en&q[i-1]|(~load)&(~en)&q[i];
            end
    endgenerate
endmodule