//1: Generator class responsible for creating and sending transactions
class Generator
    
    // Random transaction object
    rand transaction T;

    // Event to signal the completion of transaction generation
    event done;

    // Mailbox to store and send transactions to Driver
    mailbox #(transaction) mbx_drv;

    // Number of transactions to generate
    int repeat_count;


    //2 Constructor: Initializes the mailbox and creates a transaction object
    function new(mailbox #(transaction) mbx_drv, int repeat_count = 10);
        this.mbx_drv = mbx_drv;
        this.repeat_count = repeat_count;
        T = new();
    endfunction

    //3 run task
    task run();
        for (int i = 0; i<repeat_count ;i++) 
            begin
                if (!T.randomize())  // Attempt to randomize the transaction
                $display("Randomization Failed at %0d", i);
            

            else 
            begin
                mbx_drv.put(T.copy());
                $display("Generator Transaction %0d:", i);
                T.display();
                mbx_drv.put(T);  // Send the transaction to the mailbox
                #1;  // Small delay
            end
            end
        ->done // Trigger the event to signal completion

    endtask //run

endclass // Generator