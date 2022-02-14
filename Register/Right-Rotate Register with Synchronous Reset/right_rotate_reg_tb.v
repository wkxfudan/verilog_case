`timescale 1ns/1ps

// simulation time: 520ns
module right_rotate_reg_tb
    #(parameter DW=4)
    ();

    reg clk;
    reg sync_rst;
    reg load;
    reg en;
    reg [DW-1:0] data;
    wire [DW-1:0] q;

    // module under test
    right_rotate_reg uut(
        .clk(clk),
        .sync_rst(sync_rst),
        .load(load),
        .en(en),
        .data(data),
        .q(q)
    );

    // clk
    initial 
        clk=0;
    always #5 clk=~clk;

    // datas
    always #10 data={$random}%(2**DW);

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
            #239 q_expect={q_expect[0],q_expect[DW-1:1]};
            #249 q_expect={q_expect[0],q_expect[DW-1:1]};
            #259 q_expect={q_expect[0],q_expect[DW-1:1]};
            #269 q_expect={q_expect[0],q_expect[DW-1:1]};
            #279 q_expect={q_expect[0],q_expect[DW-1:1]};
            #289 q_expect={q_expect[0],q_expect[DW-1:1]};
            #299 q_expect={q_expect[0],q_expect[DW-1:1]};
            #309 q_expect=data;
            #319 q_expect={q_expect[0],q_expect[DW-1:1]};
            #329 q_expect={q_expect[0],q_expect[DW-1:1]};
            #339 q_expect={q_expect[0],q_expect[DW-1:1]};
            #349 q_expect={q_expect[0],q_expect[DW-1:1]};
            #359 q_expect={q_expect[0],q_expect[DW-1:1]};
            #369 q_expect={q_expect[0],q_expect[DW-1:1]};
            #379 q_expect={q_expect[0],q_expect[DW-1:1]};
            #389 q_expect=data;
            #399 q_expect={q_expect[0],q_expect[DW-1:1]};
            #409 q_expect={q_expect[0],q_expect[DW-1:1]};
            #419 q_expect={q_expect[0],q_expect[DW-1:1]};
            #429 q_expect={q_expect[0],q_expect[DW-1:1]};
            #439 q_expect={q_expect[0],q_expect[DW-1:1]};
            #449 q_expect={q_expect[0],q_expect[DW-1:1]};
            #459 q_expect={q_expect[0],q_expect[DW-1:1]};
            #469 q_expect=data;
            #479 q_expect={q_expect[0],q_expect[DW-1:1]};
            #489 q_expect={q_expect[0],q_expect[DW-1:1]};
            #499 q_expect={q_expect[0],q_expect[DW-1:1]};
            #509 q_expect={q_expect[0],q_expect[DW-1:1]};
            #519 q_expect={q_expect[0],q_expect[DW-1:1]};
        join

    wire success;                  // success==1 means q==q_expect
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
                $display("SIMULATION FAILED");
        end
endmodule

