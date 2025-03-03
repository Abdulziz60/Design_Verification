`include "uvm_macros.svh"
import  uvm_pkg::*;

`include "../dsesign/dut.sv"
`include "../dsesign/dut_if.sv"
`include "../TB/env.sv"
`include "../TB/sequence_item.sv"
`include "../TB/my_sequence.sv"
`include "../TB/my_test.sv"




module top ;

    logic clk;

    dut_if if1(.clk(clk));
    adder DUT(.aif(if1));

    initial clk = 0;
    always #5 clk = ~clk;

    
    initial begin
        
        uvm_config_db #(virtual dut_if)::set(null,"*","dut_if",if1);
        run_test("my_test");

    end


endmodule