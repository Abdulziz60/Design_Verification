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

initial clk = 0; 
always #5 clk = ~clk;
    
always_ff @(posedge clk ) begin 
    $display("start tast");

    initial begin
  
    //   repeat (10 ) begin 
    //   a = $urandom_range(0,1);
    //   b = $urandom_range(0,1);
    //   enable = $urandom_range(0,1);
    //   rst_n = $urandom_range(0,1);

    //   @(posedge clk);
      check_output();
    end
    $display("TEST PASSED");
    $finish;
    end

    initial begin
   
    always_ff @(negedge clk)
    a = 0; b = 0; rst_n = 0; enable = 0; 
    @(negedge clk) expect_test( z <= 0 );

    a = 0; b = 0; rst_n = 1; enable = 1; 
    @(negedge clk) expect_test( z <= z );
    
    a = 1; b = 0; rst_n = 1; enable = 1; 
    @(negedge clk) expect_test( z <= 0 );
    
    a = 0; b = 1; rst_n = 1; enable = 1; 
    @(negedge clk) expect_test( z <= 0 );
    
    a = 1; b = 1; rst_n = 1; enable = 1; 
    @(negedge clk) expect_test( z <= 1 );
    
    a = 1; b = 1; rst_n = 1; enable = 0; 
    @(negedge clk) expect_test( z <= z );
    
    a = 1; b = 1; rst_n = 0; enable = 1;
    @(negedge clk) expect_test( z <= 0 );
    
    a = 1; b = 1; rst_n = 0; enable = 0; 
    @(negedge clk) expect_test( z <= z );

    $display("TEST PASSED");
    $finish;
  end

    task check_output();
    logic expect_test;
    
    if (z !== expect_test ) begin
        $display("TEST FAILED: a=%d, b=%d, out=%d, expected=%d", 
            a, b, opcode, z, expect_test);
            $finish;
    end
  endtask


endmodule