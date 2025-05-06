//----------------------------------------------------------------------
// Class: i2c_sequencer_master
//
// Description:
//   This is a UVM sequencer used to control the flow of i2c_seq_item
//   transactions from sequences to the i2c_driver_master.
//
// Purpose:
//   Acts as a channel between sequences and the driver. It arbitrates
//   the sequence items and forwards them to the driver when requested.
//
// Usage:
//   - Instantiated inside the i2c_agent_master.
//   - Receives i2c_seq_item transactions from sequences like i2c_seq
//     or i2c_test_plan_seq.
//   - Connected to the master driver via the sequencer-port.
//
// Note:
//   No additional functionality is added in this class for now,
//   but it provides a named type that can be extended later if needed.
//
//----------------------------------------------------------------------

`ifndef I2C_SEQUENCER_MASTER_SV
`define I2C_SEQUENCER_MASTER_SV

`include "uvm_macros.svh"
import uvm_pkg::*;


class i2c_sequencer_master extends uvm_sequencer #(i2c_seq_item);
  `uvm_component_utils(i2c_sequencer_master)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass

`endif