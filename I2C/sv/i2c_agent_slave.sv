`ifndef I2C_AGENT_SLAVE_SV
`define I2C_AGENT_SLAVE_SV


import uvm_pkg::*;
`include "uvm_macros.svh"

`include "../sv/i2c_monitor_slave.sv"

class i2c_agent_slave extends uvm_agent;
  `uvm_component_utils(i2c_agent_slave)

  i2c_monitor_slave monitor;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "i2c_monitor_slave build", UVM_LOW)
    monitor = i2c_monitor_slave::type_id::create("monitor", this);
  endfunction

endclass

`endif