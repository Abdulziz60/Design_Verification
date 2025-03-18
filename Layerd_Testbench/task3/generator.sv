class generator ;
    
   

    virtual adder_if vif;
     transaction trans;

    function new (virtual adder_if vif);
        
        this.vif = vif ;
        trans = new();

    endfunction

    task run();

        // for (int i = 0; i < 5; i++)begin
        repeat(5) begin
                if(!trans.randomize())
                    $display("Randomiation failed");

                    vif.a = trans.a;
                    vif.b = trans.b;
                    #1;
                    // $display("num of I =%d , a = %d, b = %d, c = %d",i, vif.a, vif.b, vif.c);

        end

    endtask

endclass //generator 