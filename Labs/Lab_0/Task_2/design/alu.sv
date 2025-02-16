timeunit 1ns;
timeprecision 100ps;
// opcode_t enum for opcode values
  typedef enum logic [2:0] {
    ADD = 3'b000,
    SUB = 3'b001, 
    MUL = 3'b010,
    OR  = 3'b011, 
    AND = 3'b100,
    XOR = 3'b101, 
    SLL = 3'b110, 
    SRL = 3'b111 
  } opcode_t;

module alu (
  output logic [7:0] out,
  output logic zero,
  input  logic clk,
  input  logic [7:0] a,
  input  logic [7:0] b,
  input  opcode_t opcode
);



always @(negedge clk) begin
  unique case (opcode)
    ADD: out <= a + b;
    SUB: out <= a - b;
    MUL: out <= a * b;
    OR:  out <= a | b;
    AND: out <= a & b;
    XOR: out <= a ^ b;
    SLL: out <= a << b;
    SRL: out <= a >> b;
    default: out <= 8'bx;
  endcase
end

always_comb begin
  zero = (out == 0);
end

endmodule
