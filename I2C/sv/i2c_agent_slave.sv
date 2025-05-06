`ifndef I2C_AGENT_SLAVE_SV
`define I2C_AGENT_SLAVE_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "../sv/i2c_monitor_slave.sv"
`include "../sv/i2c_driver_slave.sv"
`include "../sv/i2c_sequencer_slave.sv"

class i2c_agent_slave extends uvm_agent;
  `uvm_component_utils(i2c_agent_slave)

  i2c_monitor_slave   monitor;
  i2c_driver_slave    driver;
  i2c_sequencer_slave sequencer;

  // Virtual interface
  virtual i2c_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), ">> SLV_AGENT: build_phase started", UVM_LOW)

    // Create components
    monitor   = i2c_monitor_slave::type_id::create("monitor", this);
    driver    = i2c_driver_slave::type_id::create("driver", this);
    sequencer = i2c_sequencer_slave::type_id::create("sequencer", this);

    // Get the virtual interface from config DB
    if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("I2C_AGENT_SLAVE", "Virtual interface i2c_if not found in config DB")
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Connect sequencer to driver
    driver.seq_item_port.connect(sequencer.seq_item_export);

    // Pass interface to subcomponents
    driver.vif  = vif;
    monitor.vif = vif;
  endfunction

endclass

`endif
