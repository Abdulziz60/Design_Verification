// yapp_tx_env.sv
`timescale 1ns/1ps
import uvm_pkg::*;
`include "uvm_macros.svh"

class yapp_env extends uvm_env;
  `uvm_component_utils(yapp_env)

  yapp_tx_agent agent;

  function new(string name = "yapp_env", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = yapp_tx_agent::type_id::create("agent", this);
  endfunction

endclass
