module multiplier_32x32 (
    input logic [31:0] a,
    input logic [31:0] b,
    output logic [63:0] product
);
    assign product = a * b;
endmodule
