`timescale 1ns/1ps

//1: Generator class responsible for creating and sending transactions
class Generator;
    
    // Random transaction object
    transaction trans;

    // Event to signal the completion of transaction generation
    event done;

    // Mailbox to store and send transactions to Driver
    mailbox #(transaction)mbx;

    // Number of transactions to generate
    int repeat_count;


    //2 Constructor: Initializes the mailbox and creates a transaction object
    function new(mailbox #(transaction) mbx, int repeat_count = 10);
        this.mbx = mbx;
        this.repeat_count = repeat_count;
        trans = new();
    endfunction

    //3 run task
    task run();
        // for (int i = 0; i<repeat_count ;i++) 
        repeat(repeat_count)
            begin
                if (!trans.randomize())  // Attempt to randomize the transaction
                $display("Randomization Failed at %0d",repeat_count );
            
                mbx.put(trans.copy());
                $display("Generator Transaction %0d.", repeat_count );
                trans.display();
                mbx.put(trans);  // Send the transaction to the mailbox
                #1;  // Small delay
            end
            
        ->done; // Trigger the event to signal completion

    endtask 

endclass // Generator