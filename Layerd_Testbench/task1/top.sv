`include "../adder.sv"
`include "../adder_if.sv"
`include "../generator.sv"

module  top ; 

    adder_if aif();

    adder DUT ( .a(aif.a), .b(aif.b), .c(aif.c));
    

    generator gen;

    initial begin

        gen = new (aif);
        gen.run();
        $finish;


    end
    
endmodule