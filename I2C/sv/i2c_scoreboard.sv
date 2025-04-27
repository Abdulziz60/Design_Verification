`ifndef I2C_SCOREBOARD_SV
`define I2C_SCOREBOARD_SV

`include "uvm_macros.svh"
import uvm_pkg::*;


class i2c_scoreboard extends uvm_component;
  `uvm_component_utils(i2c_scoreboard)

  uvm_analysis_imp #(i2c_seq_item, i2c_scoreboard) ap;

  // Memory model to track writes
  bit [7:0] memory [0:127];

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  virtual function void write(i2c_seq_item t);
  if (t.rw == 0) begin
    // Write transaction: update memory model
    memory[t.address] = t.data;
    `uvm_info(get_type_name(), $sformatf("WRITE OK: Addr=0x%0h, Data=0x%0h", t.address, t.data), UVM_LOW)
  end else begin
    // Read transaction: check memory model
    if (memory[t.address] == t.data) begin
      `uvm_info(get_type_name(), $sformatf("READ PASS: Addr=0x%0h, Data=0x%0h", t.address, t.data), UVM_LOW)
    end else begin
      `uvm_error(get_type_name(), $sformatf("READ FAIL: Addr=0x%0h, Expected=0x%0h, Got=0x%0h", t.address, memory[t.address], t.data))
    end
  end
endfunction


endclass


`endif
