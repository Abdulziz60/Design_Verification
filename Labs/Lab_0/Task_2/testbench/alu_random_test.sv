timeunit 1ns;
timeprecision 100ps;

module alu_directed_test;

  logic [7:0] out;
  logic zero;
  logic clk;
  logic [7:0] a;
  logic [7:0] b;
  opcode_t opcode;

  alu dut (
    .out(out),
    .zero(zero),
    .clk(clk),
    .a(a),
    .b(b),
    .opcode(opcode)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0;

    repeat (100 ) begin 
      a = $urandom_range(0, 255);
      b = $urandom_range(0, 255);
      opcode = opcode_t'($urandom_range(0, 7));

      @(posedge clk);
      check_output();
    end

    $display("ALU RANDOMIZED TEST PASSED");
    $finish;
  end
// Task to Check Outputs
  task check_output();
    logic [7:0] expected_out;
    logic expected_zero;

    // Calculate expected output based on opcode
    case (opcode)
      ADD: expected_out = a + b;
      SUB: expected_out = a - b;
      MUL: expected_out = a * b;
      OR:  expected_out = a | b;
      AND: expected_out = a & b;
      XOR: expected_out = a ^ b;
      SLL: expected_out = a << b;
      SRL: expected_out = a >> b;
      default: expected_out = 8'bx;
    endcase

    expected_zero = (expected_out == 0);


// Validate the output
    if (out !== expected_out || zero !== expected_zero) begin
      $display("TEST FAILED: a=%d, b=%d, opcode=%b, out=%d, expected=%d, zero=%b", 
                a, b, opcode, out, expected_out, zero);
      $finish;
    end
  endtask

endmodule
