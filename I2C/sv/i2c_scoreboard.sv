//============================================================
// File: i2c_scoreboard.sv
// Description: Scoreboard for I2C transactions
//============================================================

`ifndef I2C_SCOREBOARD_SV
`define I2C_SCOREBOARD_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

// Define analysis implementations for master and slave
`uvm_analysis_imp_decl(_master)
`uvm_analysis_imp_decl(_slave)

class i2c_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(i2c_scoreboard)

  uvm_analysis_imp_master#(i2c_seq_item, i2c_scoreboard) master_imp;
  uvm_analysis_imp_slave#(i2c_seq_item, i2c_scoreboard)  slave_imp;

  bit [7:0] expected_mem[bit[6:0]];

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    master_imp = new("master_imp", this);
    slave_imp  = new("slave_imp", this);
  endfunction

  // WRITE from master
  function void write_master(i2c_seq_item tr);
    if (tr.op == I2C_WRITE) begin
      expected_mem[tr.address] = tr.data;
      `uvm_info(get_type_name(), $sformatf("WRITE ✅ Addr=0x%0h, Data=0x%0h", tr.address, tr.data), UVM_LOW)
    end
  endfunction

  // READ check from slave
  function void write_slave(i2c_seq_item tr);
    if (tr.op == I2C_READ) begin
      bit [7:0] expected = expected_mem.exists(tr.address) ? expected_mem[tr.address] : 8'h00;
      if (tr.data !== expected) begin
        `uvm_error(get_type_name(), $sformatf("READ ❌ Addr=0x%0h, Expected=0x%0h, Got=0x%0h", tr.address, expected, tr.data))
      end else begin
        `uvm_info(get_type_name(), $sformatf("READ ✅ Addr=0x%0h, Data=0x%0h", tr.address, tr.data), UVM_LOW)
      end
    end
  endfunction

endclass

`endif
