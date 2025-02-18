interface adder_if;

        logic [3:0] a;
        logic [3:0] b;
        logic [4:0] c;

        modport DUT (
        output a,
        output b,
        input c
        );

       


endinterface