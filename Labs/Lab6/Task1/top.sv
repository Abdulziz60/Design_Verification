// `include "alu.sv"
// `include "../Task1/alu_test.sv"
// `include "../Task1/randtrans.sv"
// `include "../Task1/alu_test.sv"

// connect the DUT and the TEST module, also generates clk
module top;

    bit clk;
    always #5 clk = ~clk;


    logic [3:0] alu_ctrl;
    logic [31:0] op1;
    logic [31:0] op2;
    logic [31:0] alu_result; 
    logic zero;


    alu DUT(
        .*,
        .alu_ctrl(alu_t'(alu_ctrl))
    );

    alu_test TEST(
        .*
    );

endmodule : top