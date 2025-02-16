module fifo_test (
    input logic clk,
    input logic rst_n,      // Controlled by top.sv
    fifo_interface fifo_if  // Interface port
);

    // Move read_data declaration to the top of the module
    logic [7:0] read_data;

    // Testbench process
    initial begin
        $dumpfile("fifo_test.vcd");
        $dumpvars(0, fifo_test);
        
        // Wait for reset deassertion
        @(posedge rst_n);

        // Write test data
        fifo_if.fifo_write(8'h10);
        fifo_if.fifo_write(8'h20);
        fifo_if.fifo_write(8'h30);
        fifo_if.fifo_write(8'h40);
        fifo_if.fifo_write(8'h50);

        // Read test data
        fifo_if.fifo_read(read_data);
        $display("Read Data: %h", read_data);
        fifo_if.fifo_read(read_data);
        $display("Read Data: %h", read_data);
        fifo_if.fifo_read(read_data);
        $display("Read Data: %h", read_data);
        fifo_if.fifo_read(read_data);
        $display("Read Data: %h", read_data);
        fifo_if.fifo_read(read_data);
        $display("Read Data: %h", read_data);

        #50;
        $finish;
    end
endmodule
