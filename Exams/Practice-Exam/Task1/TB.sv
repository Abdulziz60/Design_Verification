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
    else 
    $display("time = %0d, test passed",$time);
    
endtask

initial begin

  rst_n = 0;
  #1;
  rst_n = 1;
  #2;
  rst_n = 0;
  #1;
  rst_n = 0;
end

initial begin
  
  @(negedge clk);
    a = 1; b = 1; rst_n = 0; enable = 1;
  @(posedge clk);
    $display("z = %d",z);
    @(negedge clk); check_output(1);  

    a = 0; b = 0; rst_n = 0; enable = 1; 
    @(negedge clk); check_output(0); 

    a = 1; b = 0; rst_n = 0; enable = 1;
    @(negedge clk); check_output(0);

    a = 0; b = 1; rst_n = 0; enable = 1;
    @(negedge clk); check_output(0);

    a = 1; b = 1; rst_n = 0; enable = 1;
    @(negedge clk); check_output(1);

    a = 1; b = 1; rst_n = 1; enable = 0;
    @(negedge clk); check_output(0); 

    $display("TEST PASSED");
    $finish;
end

initial begin
    $monitor("time = %0d, clk = %0d ,a = %0d, b = %0d, res_n = %0d, enabel = %0d, output = %0d",$time,clk, a, b, rst_n, enable ,z);
end

endmodule
