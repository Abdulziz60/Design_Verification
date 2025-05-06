`ifndef I2C_ENV_SV
`define I2C_ENV_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class i2c_env extends uvm_env;
  `uvm_component_utils(i2c_env)

  i2c_agent_master master_agent;
  i2c_agent_slave  slave_agent;
  i2c_scoreboard   sb;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    master_agent = i2c_agent_master::type_id::create("master_agent", this);
    slave_agent  = i2c_agent_slave::type_id::create("slave_agent", this);
    sb           = i2c_scoreboard::type_id::create("sb", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    master_agent.monitor.ap.connect(sb.master_imp);
    slave_agent.monitor.ap.connect(sb.slave_imp);
  endfunction
endclass

`endif
