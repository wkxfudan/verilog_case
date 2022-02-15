`timescale 1ns/1ps

// simulation time: 520ns
module univ_rotate_reg_tb
    #(parameter DW=4)
    ();

    reg clk;
    reg async_rst;
    reg [1:0] ctrl;
    reg [DW-1:0] data;
    wire [DW-1:0] q;

    // module under test
    univ_rotate_reg uut(
        .clk(clk),
        .async_rst(async_rst),
        .ctrl(ctrl),
        .data(data),
        .q(q)
    );

    // clk
    initial 
        clk=0;
    always #5 clk=~clk;

    // datas
    initial data={$random}%(2**DW);
    always #10 data={$random}%(2**DW);

    // input signals
    initial
        fork
            async_rst=1;
            #3 async_rst=0;

            // test loading, left-shifting and holding
            ctrl=2'b00;
            #10 ctrl=2'b10;
            #30 ctrl=2'b11;
            #50 ctrl=2'b10;
            #70 ctrl=2'b11;
            #90 ctrl=2'b10;
            #110 ctrl=2'b11;

            #130 ctrl=2'b00;
            #140 ctrl=2'b10;
            #160 ctrl=2'b11;
            #180 ctrl=2'b10;
            #200 ctrl=2'b11;
            #220 ctrl=2'b10;
            #240 ctrl=2'b11;

            // test loading, right-shifting and holding
            #260 ctrl=2'b00;
            #270 ctrl=2'b01;
            #290 ctrl=2'b11;
            #310 ctrl=2'b01;
            #330 ctrl=2'b11;
            #350 ctrl=2'b01;
            #370 ctrl=2'b11;

            #390 ctrl=2'b00;
            #400 ctrl=2'b01;
            #420 ctrl=2'b11;
            #440 ctrl=2'b01;
            #460 ctrl=2'b11;
            #480 ctrl=2'b01;
            #500 ctrl=2'b11;
        join

    // auto check
    reg [DW-1:0] q_expect;
    
    initial
        fork
            #9 q_expect=data;
            #19 q_expect={q_expect[DW-2:0],q_expect[DW-1]};
            #29 q_expect={q_expect[DW-2:0],q_expect[DW-1]};
            #39 q_expect=q_expect;
            #49 q_expect=q_expect;
            #59 q_expect={q_expect[DW-2:0],q_expect[DW-1]};
            #69 q_expect={q_expect[DW-2:0],q_expect[DW-1]};
            #79 q_expect=q_expect;
            #89 q_expect=q_expect;
            #99 q_expect={q_expect[DW-2:0],q_expect[DW-1]};
            #109 q_expect={q_expect[DW-2:0],q_expect[DW-1]};
            #119 q_expect=q_expect;
            #129 q_expect=q_expect;

            #139 q_expect=data;
            #149 q_expect={q_expect[DW-2:0],q_expect[DW-1]};
            #159 q_expect={q_expect[DW-2:0],q_expect[DW-1]};
            #169 q_expect=q_expect;
            #179 q_expect=q_expect;
            #189 q_expect={q_expect[DW-2:0],q_expect[DW-1]};
            #199 q_expect={q_expect[DW-2:0],q_expect[DW-1]};
            #209 q_expect=q_expect;
            #219 q_expect=q_expect;
            #229 q_expect={q_expect[DW-2:0],q_expect[DW-1]};
            #239 q_expect={q_expect[DW-2:0],q_expect[DW-1]};
            #249 q_expect=q_expect;
            #259 q_expect=q_expect;

            #269 q_expect=data;
            #279 q_expect={q_expect[0],q_expect[DW-1:1]};
            #289 q_expect={q_expect[0],q_expect[DW-1:1]};
            #299 q_expect=q_expect;
            #309 q_expect=q_expect;
            #319 q_expect={q_expect[0],q_expect[DW-1:1]};
            #329 q_expect={q_expect[0],q_expect[DW-1:1]};
            #339 q_expect=q_expect;
            #349 q_expect=q_expect;
            #359 q_expect={q_expect[0],q_expect[DW-1:1]};
            #369 q_expect={q_expect[0],q_expect[DW-1:1]};
            #379 q_expect=q_expect;
            #389 q_expect=q_expect;

            #399 q_expect=data;
            #409 q_expect={q_expect[0],q_expect[DW-1:1]};
            #419 q_expect={q_expect[0],q_expect[DW-1:1]};
            #429 q_expect=q_expect;
            #439 q_expect=q_expect;
            #449 q_expect={q_expect[0],q_expect[DW-1:1]};
            #459 q_expect={q_expect[0],q_expect[DW-1:1]};
            #469 q_expect=q_expect;
            #479 q_expect=q_expect;
            #489 q_expect={q_expect[0],q_expect[DW-1:1]};
            #499 q_expect={q_expect[0],q_expect[DW-1:1]};
            #509 q_expect=q_expect;
            #519 q_expect=q_expect;
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
                result=result&success;
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
            $stop;
        end
endmodule

