interface adder_if;

        logic [7:0] a;
        logic [7:0] b;
        logic [8:0] c;

        modport DUT (
        output a,
        output b,
        input c
        );

       


endinterface