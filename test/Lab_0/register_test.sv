module register_test;

    // Correct signal declarations
    wire [7:0] out;       
    reg [7:0] data;
    reg enable;
    reg rst_ = 1'b1;
    reg clk = 1'b1;

    // DUT instantiation
    register r1 (
        .enable(enable),
        .clk(clk),
        .out(out),        // Now connected correctly to a wire
        .data(data),
        .rst_(rst_)
    );

    // Clock generation
    always #5 clk = ~clk;

initial begin
    // Apply reset before starting the test
    rst_ = 0;    // Assert reset (active-low)
    enable = 0;
    data = 8'b0;
    @(negedge clk);
    
    rst_ = 1;    // De-assert reset
    @(negedge clk);

    // Test cases after reset
    { rst_, enable, data } = 10'b1_0_10101010; @(negedge clk) expect_test(8'h00);
    { rst_, enable, data } = 10'b1_1_11001100; @(negedge clk) expect_test(8'hCC);
    { rst_, enable, data } = 10'b1_0_11111111; @(negedge clk) expect_test(8'hCC);
    
    $display("REGISTER TEST PASSED");
    $finish;
end

    // Monitoring and timeout handling
    initial begin
        $monitor("time=%0t enable=%b rst_=%b data=%h out=%h", $time, enable, rst_, data, out);
        #500; // Timeout to avoid infinite loop
        $display("REGISTER TEST TIMEOUT");
        $finish;
    end

    // Task to verify results
    task expect_test(input [7:0] expects);
        if (out !== expects) begin
            $display("TEST FAILED at time %0t: out=%b, expected=%b", $time, out, expects);
            $finish;
        end
    endtask

endmodule
