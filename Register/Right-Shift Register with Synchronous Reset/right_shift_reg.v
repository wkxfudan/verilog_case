`timescale 1ns/1ps

module right_shift_reg
    #(parameter DW=4)
    (
    input wire clk,
    input wire sync_rst,
    input wire load,
    input wire en,
    input wire [DW-1:0] data,
    input wire data_h,
    output reg [DW-1:0] q
    );

    // bit DW-1
    always @(posedge clk)
        q[DW-1]<=   (~sync_rst)
                    &(load&data[DW-1]|(~load)&en&data_h|(~load)&(~en)&q[DW-1]);

    // bit [DW-2:0]
    genvar i;
    generate
        for(i=0;i<DW-1;i=i+1)
            begin:dff_array
                always @(posedge clk)
                    q[i]<=  (~sync_rst)&
                            (load&data[i]|(~load)&en&q[i+1]|(~load)&(~en)&q[i]);
            end
    endgenerate
endmodule