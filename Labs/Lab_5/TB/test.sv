`include "../desing/mem.sv"
`include "../TB/transaction.sv"
`include "../TB/generator.sv"
`timescale 1ns/1ps

module test;

    // **Mailbox for transaction communication**
    mailbox #(transaction) mbx;

    // **Generator instance**
    Generator gen;

    // **Testbench Initialization**
    initial begin
        // Create a mailbox
        mbx = new();

        // Instantiate Generator with mailbox and repeat count of 5 transactions
        gen = new(mbx, 5);

        // Run the generator
        fork
            gen.run();
        join_none

        // Wait for completion event
        wait(gen.done);

        // End simulation
        $display("Simulation Completed!");
        $finish;
    end

endmodule
