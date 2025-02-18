// Monitor class responsible for observing DUT signals and sending transactions to Scoreboard
class Monitor;

    // Transaction object to hold observed data from DUT
    trans T;  

    // Mailbox to send transactions to Scoreboard
    mailbox #(trans) mbx;  

    // Virtual interface to connect with DUT and observe its signals
    virtual adder_if aif;  

    // Constructor: Initializes mailbox and interface, creates a new transaction object
    function new(virtual adder_if aif, mailbox #(trans) mbx);
        this.aif = aif;  // Store the interface handle
        this.mbx = mbx;  // Store the mailbox handle
        T = new();       // Create a new transaction object
    endfunction

    // Task to continuously monitor DUT signals and send them to Scoreboard
    task run();
        forever begin  

            @(aif.a, aif.b, aif.c);  // Wait for any change in DUT signals
          
            #1;  // Small delay to avoid race conditions

            // Capture DUT values into the transaction object
            T.a = aif.a;
            T.b = aif.b;
            T.c = aif.c;

            // Print the captured values for debugging
            $display("Monitor: a = %d, b = %d, c = %d", T.a, T.b, T.c);

            // Send the transaction to the Scoreboard for verification
            mbx.put(T);  
            
        end
    endtask

endclass // Monitor
