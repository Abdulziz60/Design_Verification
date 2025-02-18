// Driver class responsible for receiving transactions and applying them to the DUT
class Driver;

    // Transaction object to hold received data
    trans T;  

    // Mailbox to receive transactions from Generator
    mailbox #(trans) mbx;  

    // Virtual interface to connect with DUT
    virtual adder_if aif;  

    // Constructor: Initializes mailbox and interface, creates a new transaction object
    function new(virtual adder_if aif, mailbox #(trans) mbx);
        this.mbx = mbx;  // Store the mailbox handle
        this.aif = aif;  // Store the interface handle
        T = new();       // Create a new transaction object
    endfunction

    // Task to receive transactions and apply them to the DUT
    task run();
        forever begin  
            mbx.get(T);  // Retrieve transaction from mailbox

            // Display the transaction details
            $display("Driver :");
            T.display();

            // Apply input values to the DUT through the interface
            aif.a = T.a;
            aif.b = T.b;
            #5;  // Small delay for simulation stability
        end
    endtask

endclass // Driver
