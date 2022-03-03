module test ;
//input
   reg          clk ;
   reg          rst_n ;
   reg          en ;
   reg  [11:0]  xin ;
   //output
   wire [28:0]  yout ;
   wire         valid ;

   parameter    SIMU_CYCLE   = 64'd1000 ;
   parameter    SIN_DATA_NUM = 200 ;
//=====================================
// 8*50MHz clk generating
   localparam   TCLK_HALF     = (10_000 >>3);//125
   initial begin
      clk = 1'b0 ;
      forever begin
         # TCLK_HALF clk = ~clk ;
      end
   end

//============================
//  reset and finish

   initial begin
      rst_n = 1'b0 ;
      # 30 ;
      rst_n = 1'b1 ;
      # (TCLK_HALF * 2 * 8  * SIMU_CYCLE) ;
      $finish ;
   end

//=======================================
// read sinx.txt to get sin data into register
   reg          [11:0] stimulus [0: SIN_DATA_NUM-1] ;
   integer      i ;
   initial begin
      $readmemh(".../cosx0p25m7p5m12bit.txt", stimulus) ;//address express by"/",rather than "\"!!!!!
      en = 0 ;
      i = 0 ;
      xin = 0 ;
      # 200 ;
      forever begin
         repeat(7)  @(negedge clk) ;
         en          = 1 ;
         xin         = stimulus[i] ;
         //en -> 0
         @(negedge clk) ;
         en          = 0 ;
         if (i == SIN_DATA_NUM-1) begin
            i = 0 ;
         end
         else begin
            i = i + 1 ;
         end
      end // forever begin
   end // initial begin

   fir_serial_low       u_fir_serial (
    .clk         (clk),
    .rstn        (rst_n),
    .en          (en),
    .xin         (xin),
    .valid       (valid),
    .yout        (yout));



// auto check
 initial
    fork
       yout_expect=0;
       #73749 yout_expect=29'h0000aff5;
       #93749 yout_expect=29'h00028d72;
       #113749 yout_expect=29'h0006215e;
       #133749 yout_expect=29'h000baa31;
       #153749 yout_expect=29'h00134be8;
       #173749 yout_expect=29'h001cc3ac;
       #193749 yout_expect=29'h00279bbf;
       #213749 yout_expect=29'h003317b7;
       #233749 yout_expect=29'h003e6a53;
       #253749 yout_expect=29'h0048c3f9;
       #273749 yout_expect=29'h00516816;
       #293749 yout_expect=29'h0057f571;
       #313749 yout_expect=29'h005c5a5d;
       #333749 yout_expect=29'h005efac5;
    join

    wire success;
    reg[28:0]yout_expect;               // success==1 means yout == yout_expect
    assign success = (yout == yout_expect);  
    integer cycle=0;            // count "20us"
    always #20_000 cycle=cycle+1; 
    reg result;
    initial result=1;
    always #20_000                  // check per 20us   
        if(cycle<14)
            begin        
                result=result&(success);
                if(success)
                    $display("%dus: passed",cycle*20);
                else
                    $display("------------%dus: failed------------",cycle*20);   
            end
    initial
        begin
            #(280_000-1);
            if(result)
                $display("SIMULATION PASSED");
            else
                $display("SIMULATION FAILED");
            $stop;
        end


endmodule // test
