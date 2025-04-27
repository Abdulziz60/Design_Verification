
`ifndef I2C_AGENT_MASTER_SV
`define I2C_AGENT_MASTER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "../sv/i2c_seq_item.sv" 
`include "../sv/i2c_sequencer_master.sv"
`include "../sv/i2c_driver_master.sv"


class i2c_agent_master extends uvm_agent;
  `uvm_component_utils(i2c_agent_master)
   
  i2c_sequencer_master sequencer;
  i2c_driver_master    driver;
  i2c_monitor_master   monitor;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sequencer = i2c_sequencer_master::type_id::create("sequencer", this);
    driver    = i2c_driver_master::type_id::create("driver", this);
    monitor   = i2c_monitor_master::type_id::create("monitor", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction

endclass


`endif