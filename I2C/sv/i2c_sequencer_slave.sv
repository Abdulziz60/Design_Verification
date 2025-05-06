`ifndef I2C_SEQUENCER_SLAVE_SV
`define I2C_SEQUENCER_SLAVE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class i2c_sequencer_slave extends uvm_sequencer #(i2c_seq_item);
  `uvm_component_utils(i2c_sequencer_slave)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass

`endif
