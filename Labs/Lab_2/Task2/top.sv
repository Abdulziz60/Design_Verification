module top;
    logic clk;
    mem_interface mem_if(clk);

    // Instantiate DUT and Testbench
    mem mem_inst(mem_if.mem_mp);
    mem_test test_inst();

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
endmodule
