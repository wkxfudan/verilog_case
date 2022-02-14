`timescale 1ns/100ps
module fft_tb ;
    reg          clk;
    reg          rstn;
    reg          en ;

    reg signed   [23:0]   x0_real;
    reg signed   [23:0]   x0_imag;
    reg signed   [23:0]   x1_real;
    reg signed   [23:0]   x1_imag;
    reg signed   [23:0]   x2_real;
    reg signed   [23:0]   x2_imag;
    reg signed   [23:0]   x3_real;
    reg signed   [23:0]   x3_imag;
    reg signed   [23:0]   x4_real;
    reg signed   [23:0]   x4_imag;
    reg signed   [23:0]   x5_real;
    reg signed   [23:0]   x5_imag;
    reg signed   [23:0]   x6_real;
    reg signed   [23:0]   x6_imag;
    reg signed   [23:0]   x7_real;
    reg signed   [23:0]   x7_imag;

    wire                  valid;
    wire signed  [23:0]   y0_real;
    wire signed  [23:0]   y0_imag;
    wire signed  [23:0]   y1_real;
    wire signed  [23:0]   y1_imag;
    wire signed  [23:0]   y2_real;
    wire signed  [23:0]   y2_imag;
    wire signed  [23:0]   y3_real;
    wire signed  [23:0]   y3_imag;
    wire signed  [23:0]   y4_real;
    wire signed  [23:0]   y4_imag;
    wire signed  [23:0]   y5_real;
    wire signed  [23:0]   y5_imag;
    wire signed  [23:0]   y6_real;
    wire signed  [23:0]   y6_imag;
    wire signed  [23:0]   y7_real;
    wire signed  [23:0]   y7_imag;

    initial begin
        clk = 0; //50MHz
        rstn = 0 ;
        #10 rstn = 1;
        forever begin
            #10 clk = ~clk; //50MHz
        end
    end

    fft8 u_fft (
      .clk        (clk    ),
      .rstn       (rstn    ),
      .en         (en     ),
      .x0_real    (x0_real),
      .x0_imag    (x0_imag),
      .x1_real    (x1_real),
      .x1_imag    (x1_imag),
      .x2_real    (x2_real),
      .x2_imag    (x2_imag),
      .x3_real    (x3_real),
      .x3_imag    (x3_imag),
      .x4_real    (x4_real),
      .x4_imag    (x4_imag),
      .x5_real    (x5_real),
      .x5_imag    (x5_imag),
      .x6_real    (x6_real),
      .x6_imag    (x6_imag),
      .x7_real    (x7_real),
      .x7_imag    (x7_imag),

      .valid      (valid),
      .y0_real    (y0_real),
      .y0_imag    (y0_imag),
      .y1_real    (y1_real),
      .y1_imag    (y1_imag),
      .y2_real    (y2_real),
      .y2_imag    (y2_imag),
      .y3_real    (y3_real),
      .y3_imag    (y3_imag),
      .y4_real    (y4_real),
      .y4_imag    (y4_imag),
      .y5_real    (y5_real),
      .y5_imag    (y5_imag),
      .y6_real    (y6_real),
      .y6_imag    (y6_imag),
      .y7_real    (y7_real),
      .y7_imag    (y7_imag));

    //data input
    initial      begin
        en = 0 ;
        x0_real = 24'd10;
        x1_real = 24'd20;
        x2_real = 24'd30;
        x3_real = 24'd40;
        x4_real = 24'd10;
        x5_real = 24'd20;
        x6_real = 24'd30;
        x7_real = 24'd40;

        x0_imag = 24'd0;
        x1_imag = 24'd0;
        x2_imag = 24'd0;
        x3_imag = 24'd0;
        x4_imag = 24'd0;
        x5_imag = 24'd0;
        x6_imag = 24'd0;
        x7_imag = 24'd0;
        
        #20 en = 1;
        #200;
        if(y0_real==24'd200 && y0_imag==24'd0
            && y1_real == 24'd0 && y1_imag==24'd0 
            && y2_real==-24'd40 && y2_imag==24'd40
            && y3_real==24'd0 && y3_imag==24'd0
            && y4_real==-24'd40 && y4_imag==24'd0
            && y5_real==24'd0 && y5_imag==24'd0
            && y6_real==-24'd40 && y6_imag==-24'd40
            && y7_real==24'd0 && y7_imag==24'd0
        ) begin
            $display("Success");
        end else begin
            $display("Failed");
        end
        $finish;
    end


endmodule