`timescale 1ns/1ps
import uvm_pkg::*;
`include "uvm_macros.svh"

class yapp_tx_monitor extends uvm_monitor;
  `uvm_component_utils(yapp_tx_monitor)

  function new(string name = "yapp_tx_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Monitor is running...", UVM_LOW)
  endtask

endclass
