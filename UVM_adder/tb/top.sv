import  uvm_pkg::*;
`include "uvm_macros.svh"

`include "../rtl/dut.sv"
`include "../sv/dut_if.sv"
`include "../sv/adder_seq_item.sv"
`include "../sv/adder_driver.sv"
`include "../sv/adder_seqr.sv"
`include "../sv/env.sv"
`include "../sv/adder_seq.sv"
`include "../sv/adder_test.sv"


module top ;

    logic clk;

    adder_if aif();
    adder DUT (.clk(aif.clk), .a(aif.a),  .b(aif.b),  .sum(aif.sum),  .Carry(aif.Carry));


    initial begin
        uvm_config_db#(virtual adder_if)::set(null, "*", "adder-if",aif);
    end
    initial begin
        run_test("adder_test");
    end
    initial clk = 0;
    always #5 clk = ~clk;

    assign aif.clk = clk;

endmodule