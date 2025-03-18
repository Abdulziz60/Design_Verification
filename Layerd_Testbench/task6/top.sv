`include "../task6/adder.sv"
`include "../task6/transaction.sv"
`include "../task6/monitor.sv"
`include "../task6/adder_if.sv"
`include "../task6/driver.sv"
`include "../task6/generator.sv"
`include "../task6/scoreboard.sv"

module  top ; 

    adder_if aif();
    

    adder DUT ( .a(aif.a), .b(aif.b), .c(aif.c));
    

    generator gen;
    scoreboard sbd;
    driver drv;
    monitor mon;
    mailbox #(transaction)mbx_gen_drv;
    mailbox #(transaction)mbx_sbd_mon;

    initial begin
        mbx_sbd_mon = new ();
        mbx_gen_drv = new ();

        gen = new (mbx_gen_drv);
        drv = new (aif,mbx_gen_drv);
        
        sbd = new (mbx_sbd_mon);
        mon = new (aif,mbx_sbd_mon);
        

        
       

        fork
            gen.run();
            drv.run();
            sbd.run();
            mon.run();
        join_any


        $finish;


    end
    
endmodule