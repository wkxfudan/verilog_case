`timescale 1ns/1ps

module univ_rotate_reg
    #(parameter DW=4)
    (
        input wire clk,
        input wire sync_rst,
        input wire [1:0] ctrl,
        input wire [DW-1:0] data,
        output reg [DW-1:0] q
    );

    // bit 0
    always @(posedge clk)
        q[0]<=  (~sync_rst)&
                ((~ctrl[1])&(~ctrl[0])&data[0]|
                (~ctrl[1])&( ctrl[0])&q[1]|
                ( ctrl[1])&(~ctrl[0])&q[DW-1]|
                ( ctrl[1])&( ctrl[0])&q[0]);


    // bit [DW-2:1]
    genvar i;
    generate
        for(i=1;i<DW-1;i=i+1)
            begin:dff_array
                always @(posedge clk)
                    q[i]<=  (~sync_rst)&
                            ((~ctrl[1])&(~ctrl[0])&data[i]|
                            (~ctrl[1])&( ctrl[0])&q[i+1]|
                            ( ctrl[1])&(~ctrl[0])&q[i-1]|
                            ( ctrl[1])&( ctrl[0])&q[i]);
            end
    endgenerate

    // bit DW-1
    always @(posedge clk or posedge sync_rst)
        q[DW-1]<=   (~sync_rst)&
                    ((~ctrl[1])&(~ctrl[0])&data[DW-1]|
                    (~ctrl[1])&( ctrl[0])&q[0]|
                    ( ctrl[1])&(~ctrl[0])&q[DW-2]|
                    ( ctrl[1])&( ctrl[0])&q[DW-1]);
endmodule