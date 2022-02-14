`timescale 1ns/1ps

module right_rotate_reg
    #(parameter DW=4)
    (
    input wire clk,
    input wire async_rst,
    input wire load,
    input wire en,
    input wire [DW-1:0] data,
    output reg [DW-1:0] q
    );

    // bit DW-1
    always @(posedge clk or posedge async_rst)
        if(async_rst)
            q[DW-1]<=0;
        else
            q[DW-1]<=load&data[DW-1]|(~load)&en&q[0]|(~load)&(~en)&q[DW-1];

    // bit [DW-2:0]
    genvar i;
    generate
        for(i=0;i<DW-1;i=i+1)
            begin:dff_array
                always @(posedge clk or posedge async_rst)
                    if(async_rst)
                        q[i]<=0;
                    else 
                        q[i]<=load&data[i]|(~load)&en&q[i+1]|(~load)&(~en)&q[i];
            end
    endgenerate
endmodule