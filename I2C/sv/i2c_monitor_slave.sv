`ifndef I2C_MONITOR_SLAVE_SV
`define I2C_MONITOR_SLAVE_SV


import uvm_pkg::*;
`include "uvm_macros.svh"


class i2c_monitor_slave extends uvm_monitor;
  `uvm_component_utils(i2c_monitor_slave)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    `uvm_info("MON_SLAVE", "Slave Monitor Started (Dummy Mode)", UVM_LOW)
    forever begin
      #10ns; // Just dummy wait to avoid hanging simulation
    end
  endtask

endclass
`endif