`timescale 1ns/1ps

// simulation time: 520ns
module left_shift_reg_tb
    #(parameter DW=4)
    ();

    reg clk;
    reg sync_rst;
    reg load;
    reg en;
    reg [DW-1:0] data;
    reg data_l;
    wire [DW-1:0] q;

    // module under test
    left_shift_reg #(.DW(DW)) uut(
        .clk(clk),
        .sync_rst(sync_rst),
        .load(load),
        .en(en),
        .data(data),
        .data_l(data_l),
        .q(q)
    );

    // clk
    initial 
        clk=0;
    always #5 clk=~clk;

    // datas
    always #10 data={$random}%(2**DW);
    always #10 data_l={$random}%2;

    // input signals
    initial
        fork
            load=0;
            en=0;
            sync_rst=1;
            #10 sync_rst=0;

            // test loading and holding
            #10 load=1;
            #20 load=0;
            #40 load=1;
            #50 load=0;
            #70 load=1;
            #80 load=0;
            #100 load=1;
            #110 load=0;
            #130 load=1;
            #140 load=0;
            #160 load=1;
            #170 load=0;
            #190 load=1;
            #200 load=0;
            #210 sync_rst=1;
            #220 sync_rst=0;

            // test shifting
            #220 en=1;
            #220 load=1;
            #230 load=0;
            #300 load=1;
            #310 load=0;
            #380 load=1;
            #390 load=0;
            #460 load=1;
            #470 load=0;
        join

    // auto check
    reg [DW-1:0] q_expect;
    reg [DW-1:0] data_hold;

    initial
        fork
            data_hold=0;
            #15 data_hold=data;
            #45 data_hold=data;
            #75 data_hold=data;
            #105 data_hold=data;
            #135 data_hold=data;
            #165 data_hold=data;
            #195 data_hold=data;
            #225 data_hold=data;
            #305 data_hold=data;
            #385 data_hold=data;
            #465 data_hold=data;
        join
    
    initial
        fork
            q_expect=0;
            #9 q_expect=0;
            #19 q_expect=data_hold;
            #49 q_expect=data_hold;
            #79 q_expect=data_hold;
            #109 q_expect=data_hold;
            #139 q_expect=data_hold;
            #169 q_expect=data_hold;
            #199 q_expect=data_hold;
            #219 q_expect=0;
            #229 q_expect=data;
            #239 q_expect={q_expect[DW-2:0],data_l};
            #249 q_expect={q_expect[DW-2:0],data_l};
            #259 q_expect={q_expect[DW-2:0],data_l};
            #269 q_expect={q_expect[DW-2:0],data_l};
            #279 q_expect={q_expect[DW-2:0],data_l};
            #289 q_expect={q_expect[DW-2:0],data_l};
            #299 q_expect={q_expect[DW-2:0],data_l};
            #309 q_expect=data;
            #319 q_expect={q_expect[DW-2:0],data_l};
            #329 q_expect={q_expect[DW-2:0],data_l};
            #339 q_expect={q_expect[DW-2:0],data_l};
            #349 q_expect={q_expect[DW-2:0],data_l};
            #359 q_expect={q_expect[DW-2:0],data_l};
            #369 q_expect={q_expect[DW-2:0],data_l};
            #379 q_expect={q_expect[DW-2:0],data_l};
            #389 q_expect=data;
            #399 q_expect={q_expect[DW-2:0],data_l};
            #409 q_expect={q_expect[DW-2:0],data_l};
            #419 q_expect={q_expect[DW-2:0],data_l};
            #429 q_expect={q_expect[DW-2:0],data_l};
            #439 q_expect={q_expect[DW-2:0],data_l};
            #449 q_expect={q_expect[DW-2:0],data_l};
            #459 q_expect={q_expect[DW-2:0],data_l};
            #469 q_expect=data;
            #479 q_expect={q_expect[DW-2:0],data_l};
            #489 q_expect={q_expect[DW-2:0],data_l};
            #499 q_expect={q_expect[DW-2:0],data_l};
            #509 q_expect={q_expect[DW-2:0],data_l};
            #519 q_expect={q_expect[DW-2:0],data_l};
        join

    wire success;               // success==1 means q==q_expect
    assign success=(q==q_expect);  

    integer cycle=0;            // count "10s"
    always #10 cycle=cycle+1; 

    reg result;
    initial result=1;
    always #10                  // check per 10s   
        if(cycle<=52)
            begin        
                result=result&(success);
                if(success)
                    $display("%ds: passed",cycle*10);
                else
                    $display("------------%ds: failed------------",cycle*10);   
            end
    
    initial
        begin
            #520;
            if(result)
                $display("SIMULATION PASSED");
            else
                $display("SIMULATION successED");
        end
endmodule

