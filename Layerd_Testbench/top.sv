`include "../adder.sv"
`include "../adder_if.sv"
`include "../transaction.sv"
`include "../generator.sv"
`include "../scoreboard.sv"

module  top ; 

    adder_if aif();
    

    adder DUT ( .a(aif.a), .b(aif.b), .c(aif.c));
    

    generator gen;
    scoreboard sbd;


    initial begin

        gen = new (aif);
       

        sbd = new (aif);
       

        fork
            gen.run();
            sbd.run();
        join_any


        $finish;


    end
    
endmodule