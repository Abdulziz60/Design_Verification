class generator ;
    
    
    transaction trans;
    mailbox #(transaction)mbx;
 
    function new (mailbox #(transaction)mbx);      
        this.mbx = mbx;
        trans = new();
    endfunction

    task run();

        // for (int i = 0; i < 5; i++)begin
        repeat(5) begin
                 if(!trans.randomize())
                     $display("Randomiation failed");
                    trans.display();
                    mbx.put(trans);
                    #1;
        end

    endtask

endclass //generator 