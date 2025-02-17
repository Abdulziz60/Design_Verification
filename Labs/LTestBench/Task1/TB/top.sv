`include "../TB/trans.sv"
`include "../desing/adder.sv"
`include "../TB/adder_if.sv"
`include "../TB/Driver.sv"
`include "../TB/Generator.sv"
`include "../TB/Checker.sv"



module top;

    adder_if aif();
    mailbox #(trans) mbx ;


    adder DUT(
            .a(aif.a), .b(aif.b), .c(aif.c) //a,b,c
    );

    Driver Drv = new (aif,mbx); //handle;
    Generator Gen; //handle
    event done_event ;
    Checker1 chk ;

    // initial begin
    // Drv= new (aif.DUT); //handle
    // end

    mailbox #(trans) mbx;

    initial begin

        mbx = new();
        Drv = new(aif,mbx); //  aif --> DUT , mbx --> Generator
        Gen = new(mbx); //  mbx --> Driver
        chk = new(aif,mbx); // aif --> DUT

        done_event = Gen.done;
        fork
            Gen.run();
            Drv.run();
            chk.run();
        join_none
        wait(done_event.triggered);
        $finish;
    end

    initial begin
        $monitor("[MONITOR] a = %d, b = %d, c = %d ", aif.a, aif.b, aif.c);

    end

endmodule
