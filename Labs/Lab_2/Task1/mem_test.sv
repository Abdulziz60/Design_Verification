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

    // Test Sequence
    initial begin
        logic [15:0] read_data;

        // Write some values
        mem_if.write_mem(8'h10, 16'h1234);
        mem_if.write_mem(8'h20, 16'hABCD);

        // Read and check values
        mem_if.read_mem(8'h10, read_data);
        $display("Read Address 0x10: %h (Expected: 0x1234)", read_data);

        mem_if.read_mem(8'h20, read_data);
        $display("Read Address 0x20: %h (Expected: 0xABCD)", read_data);

        #50;
        $finish;
    end
endmodule
