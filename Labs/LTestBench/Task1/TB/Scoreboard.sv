// Scoreboard class responsible for checking DUT outputs against expected values
class Scoreboard;

    // Transaction object to hold received data from Monitor
    trans T;  

    // Mailbox to receive transactions from Monitor
    mailbox #(trans) mbx;  

    // Constructor: Initializes mailbox and creates a new transaction object
    function new(mailbox #(trans) mbx);
        this.mbx = mbx;  // Store the mailbox handle
        T = new();       // Create a new transaction object
    endfunction

    // Task to continuously check DUT outputs
    task run();
        forever begin
            mbx.get(T);  // Receive transaction from Monitor
			#1;
            // Compare DUT output with expected value
            if (T.c !== (T.a + T.b))
                $display("Scoreboard: Test Failed! %d + %d != %d", T.a, T.b, T.c);
            else
                $display("Scoreboard: Test Passed! %d + %d = %d", T.a, T.b, T.c);
        end
    endtask

endclass // Scoreboard
