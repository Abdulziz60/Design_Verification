module mem_test;
    logic clk;
    mem_interface mem_if(clk);

    // Instantiate Memory
    mem mem_inst(mem_if.mem_mp);

    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Define an array to store written values
    logic [15:0] expected_mem [0:255];

    // Test Sequence
    initial begin
        logic [15:0] read_data;
        int i;
        bit test_pass = 1; // Flag to check if all values match

        // Write random values to memory
        for (i = 0; i < 256; i++) begin
            expected_mem[i] = $random; // Generate random 16-bit value
            mem_if.write_mem(i, expected_mem[i]); // Write to memory
        end

        // Read back and compare
        for (i = 0; i < 256; i++) begin
            mem_if.read_mem(i, read_data);
            if (read_data !== expected_mem[i]) begin
                $display("ERROR: Mismatch at Address 0x%2h: Read %h, Expected %h", i, read_data, expected_mem[i]);
                test_pass = 0; // Set test flag to fail
            end
        end

        if (test_pass)
            $display("TEST PASSED: All memory values matched.");
        else
            $display("TEST FAILED: Some values did not match.");

        #50;
        $finish;
    end
endmodule
