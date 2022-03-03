//3 stages integrator
module integrator
    #(parameter NIN     = 12,
      parameter NOUT    = 21)
    (
      input               clk ,
      input               rstn ,
      input               en ,
      input [NIN-1:0]     din ,
      output              valid ,
      output [NOUT-1:0]   dout) ;

    reg [NOUT-1:0]         int_d0  ;
    reg [NOUT-1:0]         int_d1  ;
    reg [NOUT-1:0]         int_d2  ;
    wire [NOUT-1:0]        sxtx = {{(NOUT-NIN){1'b0}}, din} ;

    //data input enable delay
    reg [2:0]              en_r ;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            en_r   <= 'b0 ;
        end
        else begin
            en_r   <= {en_r[1:0], en};
        end
    end

    //integrator
    //stage1
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            int_d0        <= 'b0 ;
        end
        else if (en) begin
            int_d0        <= int_d0 + sxtx ;
        end
    end

    //stage2
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            int_d1        <= 'b0 ;
        end
        else if (en_r[0]) begin
            int_d1        <= int_d1 + int_d0 ;
        end
    end

   //stage3
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            int_d2        <= 'b0 ;
        end
        else if (en_r[1]) begin
            int_d2        <= int_d2 + int_d1 ;
        end
    end
    assign dout  = int_d2 ;
    assign valid = en_r[2];

endmodule

module  decimation
    #(parameter NDEC = 21)
    (
     input                clk,
     input                rstn,
     input                en,
     input [NDEC-1:0]     din,
     output               valid,
     output [NDEC-1:0]    dout);

    reg                  valid_r ;
    reg [2:0]            cnt ;
    reg [NDEC-1:0]       dout_r ;

    //counter
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            cnt <= 3'b0;
        end
        else if (en) begin
            if (cnt==4) begin
                cnt <= 'b0 ;
            end
            else begin
                cnt <= cnt + 1'b1 ;
            end
        end
    end

    //data, valid
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            valid_r        <= 1'b0 ;
            dout_r         <= 'b0 ;
        end
        else if (en) begin
            if (cnt==4) begin
                valid_r     <= 1'b1 ;
                dout_r      <= din;
            end
            else begin
                valid_r     <= 1'b0 ;
            end
        end
    end
    assign dout          = dout_r ;
    assign valid         = valid_r ;

endmodule

module comb
    #(parameter NIN  = 21,
      parameter NOUT = 17)
    (
     input               clk,
     input               rstn,
     input               en,
     input [NIN-1:0]     din,
     input               valid,
     output [NOUT-1:0]   dout);

    //en delay
    reg [5:0]                 en_r ;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            en_r <= 'b0 ;
        end
        else if (en) begin
            en_r <= {en_r[5:0], en} ;
        end
    end
 
    reg [NOUT-1:0]            d1, d1_d, d2, d2_d, d3, d3_d ;
    //stage 1, as fir filter, shift and add(sub),
    //no need for multiplier
    always @(posedge clk or negedge rstn) begin
        if (!rstn)        d1     <= 'b0 ;
        else if (en)      d1     <= din ;
    end
    always @(posedge clk or negedge rstn) begin
        if (!rstn)        d1_d   <= 'b0 ;
        else if (en)      d1_d   <= d1 ;
    end
    wire [NOUT-1:0]      s1_out = d1 - d1_d ;

    //stage 2
    always @(posedge clk or negedge rstn) begin
        if (!rstn)        d2     <= 'b0 ;
        else if (en)      d2     <= s1_out ;
    end
    always @(posedge clk or negedge rstn) begin
        if (!rstn)        d2_d   <= 'b0 ;
        else if (en)      d2_d   <= d2 ;
    end
    wire [NOUT-1:0]      s2_out = d2 - d2_d ;

    //stage 3
    always @(posedge clk or negedge rstn) begin
        if (!rstn)        d3     <= 'b0 ;
        else if (en)      d3     <= s2_out ;
    end
    always @(posedge clk or negedge rstn) begin
        if (!rstn)        d3_d   <= 'b0 ;
        else if (en)      d3_d   <= d3 ;
    end
    wire [NOUT-1:0]      s3_out = d3 - d3_d ;

    //tap the output data for better display
    reg [NOUT-1:0]       dout_r ;
    reg                  valid_r ;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            dout_r         <= 'b0 ;
            valid_r        <= 'b0 ;
        end
        else if (en) begin
            dout_r         <= s3_out ;
            valid_r        <= 1'b1 ;
        end
        else begin
            valid_r        <= 1'b0 ;
        end
    end
    assign       dout    = dout_r ;
    assign       valid   = valid_r ;

endmodule

module cic
    #(parameter NIN  = 12,
      parameter NMAX = 21,
      parameter NOUT = 17)
    (
     input               clk,
     input               rstn,
     input               en,
     input [NIN-1:0]     din,
     input               valid,
     output [NOUT-1:0]   dout);

    wire [NMAX-1:0]      itg_out ;
    wire [NMAX-1:0]      dec_out ;
    wire [1:0]           en_r ;

    integrator   #(.NIN(NIN), .NOUT(NMAX))
    u_integrator (
       .clk         (clk),
       .rstn        (rstn),
       .en          (en),
       .din         (din),
       .valid       (en_r[0]),
       .dout        (itg_out));

    decimation   #(.NDEC(NMAX))
    u_decimator (
       .clk         (clk),
       .rstn        (rstn),
       .en          (en_r[0]),
       .din         (itg_out),
       .dout        (dec_out),
       .valid       (en_r[1]));

    comb         #(.NIN(NMAX), .NOUT(NOUT))
    u_comb (
       .clk         (clk),
       .rstn        (rstn),
       .en          (en_r[1]),
       .din         (dec_out),
       .valid       (valid),
       .dout        (dout));

endmodule