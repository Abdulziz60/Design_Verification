class monitor;
    
   
    transaction trans;
    virtual adder_if vif;
    mailbox #(transaction) mbx;

    function new (virtual adder_if vif, mailbox #(transaction)mbx);
        
        this.vif = vif ;
        this.mbx = mbx ;
        trans = new() ;
    endfunction

    task run();

        forever begin
            @(vif.a, vif.b, vif.c);
            trans.a = vif.a;
            trans.b = vif.b;
            trans.c = vif.c;
            
            $display("[ MON : ]");
            trans.display();
            mbx.put(trans);
        end

    endtask

endclass //monitor 