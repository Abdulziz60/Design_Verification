timeunit 1ns;
timeprecision 1ns;

module and_ff_test (
    input  logic clk, 
    output logic rst_n, 
    output logic enable, 
    output logic a, 
    output logic b, 
    input  logic z
);

// Clock Generation
// initial clk = 0; 
// always #5 clk = ~clk;
    
task check_output(logic expected);
    if (z !== expected) begin
        $display("TEST FAILED: a=%d, b=%d, enable=%d, rst_n=%d, z=%d, expected=%d", 
            a, b, enable, rst_n, z, expected);
        $finish;
    end 
endtask

initial begin

  rst_n = 1;
  #1;
  rst_n = 0;
  #2;
  rst_n = 1;
  #2;
  
end

initial begin
    a = 0; b = 0; rst_n = 0; enable = 0;
    @(negedge clk); check_output(0);  

    a = 0; b = 0; rst_n = 1; enable = 1; 
    @(negedge clk); check_output(z); // Output should remain unchanged

    a = 1; b = 0; rst_n = 1; enable = 1;
    @(negedge clk); check_output(0);

    a = 0; b = 1; rst_n = 1; enable = 1;
    @(negedge clk); check_output(0);

    a = 1; b = 1; rst_n = 1; enable = 1;
    @(negedge clk); check_output(1);

    a = 1; b = 1; rst_n = 1; enable = 0;
    @(negedge clk); check_output(z); // Should remain unchanged

    a = 1; b = 1; rst_n = 0; enable = 1;
    @(negedge clk); check_output(0);

    a = 1; b = 1; rst_n = 0; enable = 0;
    @(negedge clk); check_output(z); // Should remain unchanged

    $display("TEST PASSED");
    $finish;
end

endmodule
