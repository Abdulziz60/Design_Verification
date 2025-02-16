module top;
    logic clk;
    logic rst_n;

    // Instantiate FIFO interface
    fifo_interface fifo_if(.clk(clk), .rst_n(rst_n));

    // Instantiate the main FIFO unit
    synchronous_fifo dut (
        .clk(clk),
        .rst_n(rst_n),
        .w_en(fifo_if.w_en),
        .r_en(fifo_if.r_en),
        .data_in(fifo_if.data_in),
        .data_out(fifo_if.data_out),
        .full(fifo_if.full),
        .empty(fifo_if.empty)
    );

    // Instantiate the Testbench for reading and writing FIFO data
    fifo_test tb (
        .clk(clk),
        .rst_n(rst_n),  // Correctly passed from top.sv
        .fifo_if(fifo_if)
    );

    // Generate the clock signal
    always #5 clk = ~clk;

    // Initialize signals in the initial block
    initial begin
        clk = 1'b0;
        rst_n = 1'b0;
        #10 rst_n = 1'b1;  // Reset Deassertion
    end
endmodule
