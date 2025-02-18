// Generator class responsible for creating and sending transactions
class Generator;

    // Random transaction object
    rand trans T;  

    // Event to signal the completion of transaction generation
    event done;  

    // Mailbox to store and send transactions to Driver
    mailbox #(trans) mbx;  

    // Constructor: Initializes the mailbox and creates a transaction object
    function new(mailbox #(trans) mbx1);
        this.mbx = mbx1;
        T = new();
    endfunction

    // Task to generate and send transactions to the Driver
    task run();
      for (int i = 0; i < 5; i++)  // Generate 5 random transactions
        begin
            if (!randomize())  // Attempt to randomize the transaction
                $display("Randomization Failed");  
            else
            begin
              mbx.put(T.copy());
                $display("Generator :");
                T.display();
                mbx.put(T);  // Send the transaction to the mailbox
                #1;  // Small delay
            end
        end
        ->done;  // Trigger the event to signal completion
    endtask

endclass //Generator
