// Random Number Generation in SystemVerilog

module random_number_gen;

    // Declare variables
    int signed_random_number;        // For $random (signed)
    int unsigned_random_number;      // For $urandom (unsigned)
    int ranged_random_number1;       // For $urandom_range
    int ranged_random_number2;       // For $urandom_range

   initial begin
    #10; // Add a 10 ns delay
    signed_random_number = $random;
    $display("Time: %0t ns, Signed Random Number: %0d", $time, signed_random_number);

    #20; // Add another 20 ns delay
    unsigned_random_number = $urandom;
    $display("Time: %0t ns, Unsigned Random Number: %0d", $time, unsigned_random_number);

    #30; // Add a 30 ns delay
    ranged_random_number1 = $urandom_range(1, 10);
    $display("Time: %0t ns, Random Number (1-10): %0d", $time, ranged_random_number1);

    $finish;
end


endmodule
