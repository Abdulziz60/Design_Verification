`include "../TB/trans.sv"
`include "../desing/adder.sv"
`include "../TB/adder_if.sv"
`include "../TB/Driver.sv"
`include "../TB/Generator.sv"
`include "../TB/Scoreboard.sv"
`include "../TB/Monitor.sv"




module top;

    adder_if aif();
    
    // Mailboxes for communication
    mailbox #(trans) mbx_gen_drv;  // Generator → Driver
    mailbox #(trans) mbx_mon_scb;  // Monitor → Scoreboard

    // DUT instantiation
    adder DUT(
        .a(aif.a), 
        .b(aif.b), 
        .c(aif.c)
    );

    // Testbench components
    Driver Drv;
    Generator Gen;
    Monitor mon;
    Scoreboard scb;

    // Declare event for completion
    event done_event;

    initial begin
        // Initialize mailboxes
        mbx_gen_drv = new();
        mbx_mon_scb = new();

        // Create testbench components
        Drv = new(aif, mbx_gen_drv);   // Driver gets data from Generator
        Gen = new(mbx_gen_drv);        // Generator sends data to Driver
        mon = new(aif, mbx_mon_scb);   // Monitor observes DUT and sends data to Scoreboard
        scb = new(mbx_mon_scb);        // Scoreboard checks the results

        // Run testbench components in parallel
        fork
            Gen.run();
            Drv.run();
            mon.run();
            scb.run();
        join_none

        // Wait for Generator to complete
        wait(Gen.done.triggered);
        #200;
        $finish;
    end

    

endmodule
