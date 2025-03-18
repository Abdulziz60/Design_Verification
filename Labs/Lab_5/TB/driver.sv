`timescale 1ns/1ps

class driver;
    
   
    transaction trans;
    virtual mem_if mif;
    mailbox #(transaction) mbx;


    function new (virtual mem_if mif, mailbox #(transaction)mbx );
        this.mif = mif;
        this.mbx = mbx;
        trans = new ;
    endfunction

    task run();
        forever begin
            mbx.get(trans);

            mif.we   = trans.we  ;
            mif.addr = trans.addr;
            mif.din  = trans.din ;
        end
    endtask
endclass