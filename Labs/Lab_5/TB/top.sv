`include "../desing/mem.sv"
`include "../TB/transaction.sv"
`include "../TB/monitor.sv"
`include "../TB/mem_interafce.sv"
`include "../TB/driver.sv"
`include "../TB/generator.sv"
`include "../TB/scoreboard.sv"

module top;

    // clock generator starts 
    bit clk = 0;
    always #5 clk = ~clk;

    mem_if  mif ();

    mem DUT (
        .clk (clk),
        .we  (mif.we),
        .addr(mif.addr),
        .din (mif.din),
        .dout(mif.dout)
    );

    // Mailboxes for communication
    mailbox #(transaction) mbx_gen_drv;
    mailbox #(transaction) mbx_sbd_mon;

    // Generator, scoreboard, driver, monitor
    Generator gen;
    scoreboard sbd;
    driver drv;
    monitor mon;

    // Testbench Initialization
    initial begin
        mbx_gen_drv = new();
        mbx_sbd_mon = new();

        gen = new(mbx_gen_drv, 50);
        drv = new(mif, mbx_gen_drv);

        sbd = new(mbx_sbd_mon);
        mon = new(mif, mbx_sbd_mon);

        fork
            gen.run();
            drv.run();
            sbd.run();
            mon.run();
        join_none

        @(gen.done);

        $display("Simulation Completed!");
        $finish;
    end

endmodule
