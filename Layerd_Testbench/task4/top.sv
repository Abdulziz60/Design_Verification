`include "../adder.sv"
`include "../transaction.sv"
`include "../adder_if.sv"
`include "../driver.sv"
`include "../generator.sv"
`include "../scoreboard.sv"

module  top ; 

    adder_if aif();
    

    adder DUT ( .a(aif.a), .b(aif.b), .c(aif.c));
    

    generator gen;
    scoreboard sbd;
    driver drv;
    mailbox #(transaction)mbx;

    initial begin
        mbx = new();
        gen = new (mbx);
        drv = new (aif,mbx);

        sbd = new (aif);
       

        fork
            gen.run();
            drv.run();
            sbd.run();
        join_any


        $finish;


    end
    
endmodule