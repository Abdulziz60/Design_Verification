class driver;
    
   
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
            mbx.get(trans);

            vif.a = trans.a;
            vif.b = trans.b;
        end
    endtask

endclass //driver 