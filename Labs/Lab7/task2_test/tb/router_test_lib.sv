`ifndef ROUTER_TEST_LIB_SV
`define ROUTER_TEST_LIB_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  router_tb tb;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("BUILD", "Build phase of base_test executed", UVM_HIGH)

    tb = router_tb::type_id::create("tb", this);
  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction

endclass : base_test

class test2 extends base_test;
  `uvm_component_utils(test2)
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass : test2

`endif
