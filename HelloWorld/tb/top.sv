// import  uvm_pkg::*;

// `include "uvm_macros.svh"

`include "../sv/dut_if.sv"
`include "../rtl/dut.sv"

`include "../sv/env.sv"
`include "../tb/hello_test.sv"



module top ;
    dut_if dut_if_inst ();
    dut dut_inst(.dif(dut_if_inst));

    
    initial begin
        
        run_test("hello_test");

    end


endmodule