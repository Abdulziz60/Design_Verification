`include "uvm_macros.svh"
import  uvm_pkg::*;

`include "../dsesign/dut.sv"
`include "../TB/dut_if.sv"
`include "../TB/env.sv"
`include "../TB/my_test.sv"



module top ;
    dut_if dut_if1();
    dut dut1(.aif(dut_if1));

    
    initial begin
        
        run_test("my_test");

    end


endmodule