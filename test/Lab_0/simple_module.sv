module simple_module;

    timeunit 1ns;
    timeprecision 100ps;

    // Declare rst and clk signals
    logic rst;
    logic clk;

    initial begin
        rst = 1'b1; // Initialize reset
        clk = 1'b0; // Initialize clock

        // Reset de-assertion after some time
        #5 rst = 1'b0;

        wait(~rst); // Wait for reset signal to drop
        #10;        // Wait for 10 time units

        $display("Current time: %t", $time); // Display current simulation time

        @(posedge clk); // Wait for positive clock edge

        $stop; // Pause for debugging
        $display("Current time: %t", $time); // Display current simulation time
        $finish; // Finish the simulation
    end

    // Clock generation
    always #5 clk = ~clk; // Generate clock with 10ns period

endmodule
