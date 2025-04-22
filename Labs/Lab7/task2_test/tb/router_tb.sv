`ifndef ROUTER_TB_SV
`define ROUTER_TB_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class router_tb extends uvm_env;
  `uvm_component_utils(router_tb)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("BUILD", "Build phase of router_tb executed", UVM_HIGH)
  endfunction

endclass : router_tb

`endif
