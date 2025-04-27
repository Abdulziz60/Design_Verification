
`ifndef I2C_SEQUENCER_MASTER_SV
`define I2C_SEQUENCER_MASTER_SV

`include "uvm_macros.svh"
import uvm_pkg::*;


class i2c_sequencer_master extends uvm_sequencer #(i2c_seq_item);
  `uvm_component_utils(i2c_sequencer_master)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "i2c sequencer master run", UVM_LOW)
  endfunction

endclass

`endif