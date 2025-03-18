`timescale 1ns/1ps

class monitor;
    
   
    transaction trans;
    virtual mem_if mif;
    mailbox #(transaction) mbx;

    function new (virtual mem_if mif, mailbox #(transaction)mbx);
        
        this.mif = mif ;
        this.mbx = mbx ;
        trans = new() ;
    endfunction

    task run();
        forever begin
            @(mif.we, mif.addr, mif.din);
            trans.we   = mif.we   ;
            trans.addr = mif.addr ;
            trans.din  = mif.din  ;

            $display("[ MON : ]");
            trans.display();
            mbx.put(trans);
        end
    endtask //run

endclass