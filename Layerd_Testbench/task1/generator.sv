
class generator ;
    
    randc bit [7:0] a,b;

    logic [8:0] c;

    virtual adder_if vif;


    function new (virtual adder_if vif);
        
        this.vif = vif ;

    endfunction

    task run();

        for (int i = 0; i < 30; i++)begin
        // repeat(10) begin
                if(!randomize())
                    $display("Randomiation failed");

                    vif.a = a;
                    vif.b = b;
                    #1;
                    $display("num of I =%d , a = %d, b = %d, c = %d",i, vif.a, vif.b, vif.c);

        end

    endtask

endclass //generator 