`timescale 1ns/1ps

class scoreboard;

    logic [7:0] expected_mem [0:31];
    
    mailbox #(transaction) mbx;
    transaction trans;

    function new(mailbox #(transaction)mbx);
        this.mbx = mbx ;
        trans = new(); 

        foreach (expected_mem[i]) begin
            expected_mem[i] = '0;
        end 
    endfunction //new()

    task run();
        forever begin
            mbx.get(trans);

            if (trans.we) begin
                // Write operation
                expected_mem[trans.addr] = trans.din;
                $display("[SCOREBOARD] Write Operation: Addr=%0d, Data=%0d",
                          trans.addr, trans.din);

            end else 
            begin
            // expected_data_Out = trans.din;
            if ( expected_mem[trans.addr] == trans.dout )
            begin
                $display("[ MON ] Tast pass: Addr=%0d, Expected Data=%0d, Actual Data=%0d", 
                                            trans.addr, expected_mem[trans.addr], trans.dout);
            end else 
            begin 
                $display("[ MON ] !!! TEST FAILED !!! --> Addr=%0d, Expected=%0d, Actual=%0d", 
                                             trans.addr, expected_mem[trans.addr], trans.dout);
                $finish;
            end           
        end
        end
    endtask


endclass //scoreboard