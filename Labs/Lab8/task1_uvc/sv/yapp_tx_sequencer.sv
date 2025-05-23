`timescale 1ns/1ps
import uvm_pkg::*;
`include "uvm_macros.svh"

class yapp_tx_sequencer extends uvm_sequencer #(yapp_packet);
  `uvm_component_utils(yapp_tx_sequencer)

  function new(string name = "yapp_tx_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction

endclass
