// contains the ALU TEST module
module alu_test(
    output logic [3:0] alu_ctrl,
    output logic [31:0] op1,
    output logic [31:0] op2,
    input logic [31:0] alu_result, 
    input logic zero, 
    input logic clk    
);

  // Define simulation parameters
  `define PERIOD 10
  `define NUM_CYCLE 10000000


  int num_error;
  bit ok;
  bit debug = 1;

  initial begin
    #(`NUM_CYCLE * `PERIOD); // Wait for the specified number of clock cycles

    $display("=======================================");
    $display("             TEST TIMEOUT             ");
    $display("=======================================");
    $display("The test has timed out! Either the test is stuck, or it requires more clock cycles.");
    $display("Increase the simulation time by modifying the NUM_CYCLE value in alu_test.sv.");
    $display("Modify `NUM_CYCLE` to a higher value and rerun the simulation.");
    
    $finish;
  end


  // Helper Tasks Here 
  task drive_and_capture(input logic [3:0] opcode, input logic [31:0] a, b, output logic [31:0] result, output logic zero_flag, input bit debug = 0);
    // Drive inputs at the negedge
    @(negedge clk);
        alu_ctrl   <= opcode;
        op1        <= a;
        op2        <= b;
    // Capture DUT response at the next negedge
    @(negedge clk);
        result      = alu_result;
        zero_flag   = zero;
    if(debug) $display("A = %d, B = %d, Operation = %d, ALU_result = %d, zero_flag = %d", a, b, opcode, result, zero_flag);

  endtask


 // Declare Covergroup inside the module
  covergroup ALU_CG @(posedge clk);
    
    // Coverpoint for op1
    op1_cp: coverpoint op1 {
      bins low_range[] = {[32'h00000000: 32'h000000FF]};  // Covers low range
      bins mid_range   = {[32'h00000100: 32'h7FFFFFFF]}; // Mid-range values
      bins high_range  = {[32'hFFFFFF00: 32'hFFFFFFFF]}; // Covers high range
      bins default_bin = default;                     // Covers all other values
    }

    // Coverpoint for op2
    op2_cp: coverpoint op2 {
      bins low_range[] = {[32'h00000000: 32'h000000FF]};  // Covers low range
      bins mid_range   = {[32'h00000100: 32'h7FFFFFFF]}; // Mid-range values
      bins high_range  = {[32'hFFFFFF00: 32'hFFFFFFFF]}; // Covers high range
      bins default_bin = default; 
    }

    // Ensure all ALU operations are exercised**
    alu_ctrl_cp: coverpoint alu_ctrl {
      bins arithmetic_ops = {0, 1, 2};  // ADD, SUB, MUL
      bins logic_ops = {3, 4, 5};       // AND, OR, XOR
      bins shift_ops = {6, 7};          // Shift operations
      bins comparison_ops = {8, 9};     // CMP, SLT
      bins special_ops = {[10:15]};     // Reserved or special ALU cases
      bins default_bin = default;     // Covers any remaining values not in other bins
    }

    //operand-ALU interactions
    // op1_op2_ctrl_cross: cross op1_cp, op2_cp, alu_ctrl_cp;


  endgroup  



    logic [31:0] rand_a, rand_b;
    logic [3:0] rand_alu_ctrl;
    logic [31:0] test_result;
    logic        test_zero;

    randtrans rtrans;
    ALU_CG alu_coverage = new();

    // Test Cases Here 
    initial begin 
        rtrans = new();
        repeat(100000) begin 
            ok = rtrans.randomize() with {
                rtrans.a inside {[0:255], [32'hFFFFFF00: 32'hFFFFFFFF]};
                rtrans.b inside {[0:255], [32'h00000100: 32'h7FFFFFFF]};
                rtrans.opcode inside {[0:15]}; // Ensure ALU control covers all cases
            };

            if (ok) begin
              drive_and_capture(rtrans.opcode, rtrans.a, rtrans.b, test_result, test_zero, debug);
              // alu_coverage.sample();
            end else begin
              $display("Randomization failed!");  
            end
        end
        for (int i = 0; i <= 255; i = i + 1) begin
        drive_and_capture(0, 32'h00000000, i, test_result, test_zero, debug);  // ADD operation
        drive_and_capture(1, 32'h000000FF, i, test_result, test_zero, debug);  // SUB operation
        drive_and_capture(2, 32'h000000AA, i, test_result, test_zero, debug);  // MUL operation
        drive_and_capture(3, 32'h00000055, i, test_result, test_zero, debug);  // AND operation
        drive_and_capture(4, 32'h000000F0, i, test_result, test_zero, debug);  // OR operation
        drive_and_capture(5, 32'h0000000F, i, test_result, test_zero, debug);  // XOR operation
        drive_and_capture(6, 32'h00000001, i, test_result, test_zero, debug);  // Shift Left
        drive_and_capture(7, 32'h00000080, i, test_result, test_zero, debug);  // Shift Right
        drive_and_capture(8, 32'h00000001, i, test_result, test_zero, debug);  // CMP equal
        drive_and_capture(9, 32'h00000002, i, test_result, test_zero, debug);  // SLT
end
    

        printstatus(0); // currently not checking the alu, only generating the stimulus
        $finish;
    end


    initial begin 
        $dumpfile("waveform.vcd");
        $dumpvars(0);
    end



    // Function to print test status
    function void printstatus(input int status);
        if (status == 0) begin
        $display("\n");
        $display("                                  _\\|/_");
        $display("                                  (o o)");
        $display(" ______________________________oOO-{_}-OOo______________________________");
        $display("|                                                                       |");
        $display("|                               TEST PASSED                             |");
        $display("|_______________________________________________________________________|");
        $display("\n");
        end else begin
        $display("Test Failed with %d Errors", status);
        $display("\n");
        $display("                              _ ._  _ , _ ._");
        $display("                            (_ ' ( `  )_  .__)");
        $display("                          ( (  (    )   `)  ) _)");
        $display("                         (__ (_   (_ . _) _) ,__)");
        $display("                             `~~`\ ' . /`~~`");
        $display("                             ,::: ;   ; :::,");
        $display("                            ':::::::::::::::'");
        $display(" ________________________________/_ __ \\________________________________");
        $display("|                                                                       |");
        $display("|                               TEST FAILED                             |");
        $display("|_______________________________________________________________________|");
        $display("\n");
        end
    endfunction

endmodule
