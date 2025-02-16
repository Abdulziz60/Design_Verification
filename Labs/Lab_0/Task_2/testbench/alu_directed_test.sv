timeunit 1ns;
timeprecision 100ps;

module alu_directed_test;

  // Signals
  logic [7:0] out;
  logic zero;
  logic clk;
  logic [7:0] a;
  logic [7:0] b;
  opcode_t opcode;

  // Instantiate the ALU
  alu dut (
    .out(out),
    .zero(zero),
    .clk(clk),
    .a(a),
    .b(b),
    .opcode(opcode)
  );

  // Clock Generation
  always #5 clk = ~clk;

  // Test Sequence
  initial begin
    clk = 0;

    a = 8'd10; b = 8'd5;  opcode = ADD; @(posedge clk) expect_test(8'h0F, 0);
    a = 8'd20; b = 8'd20; opcode = SUB; @(posedge clk) expect_test(8'h00, 1);
    a = 8'd4;  b = 8'd3;  opcode = MUL; @(posedge clk) expect_test(8'h0C, 0);
    a = 8'b1100; b = 8'b1010; opcode = OR;  @(posedge clk) expect_test(8'b1110, 0);
    a = 8'b1100; b = 8'b1010; opcode = AND; @(posedge clk) expect_test(8'b1000, 0);
    a = 8'b1100; b = 8'b1010; opcode = XOR; @(posedge clk) expect_test(8'b0110, 0);
    a = 8'b0001; b = 3'd2;    opcode = SLL; @(posedge clk) expect_test(8'b0100, 0);
    a = 8'b1000; b = 3'd3;    opcode = SRL; @(posedge clk) expect_test(8'b0001, 0);

    $display("ALU TEST PASSED");
    $finish;
  end

  // Task to Check Outputs
  task expect_test(input [7:0] expected_out, input expected_zero);
    if (out !== expected_out || zero !== expected_zero) begin
      $display("TEST FAILED: a=%d, b=%d, opcode=%b, out=%d, expected=%d", 
                a, b, opcode, out, expected_out);
      $finish;
    end
  endtask

endmodule
