interface adder_if;

logic [7:0] a,b;
logic [8:0] c;
    

modport DUT  (input a, input b, output c);
modport TEST (output a, output b, input c);

endinterface //adder_if