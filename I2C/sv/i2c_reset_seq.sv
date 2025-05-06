//============================================================
// File: i2c_reset_seq.sv
// Description: Reset sequence for I2C
//============================================================

`ifndef I2C_RESET_SEQ_SV
`define I2C_RESET_SEQ_SV

class i2c_reset_seq extends uvm_sequence #(i2c_seq_item);
  `uvm_object_utils(i2c_reset_seq)

  function new(string name = "i2c_reset_seq");
    super.new(name);
  endfunction

  virtual task body();
    i2c_seq_item tr = i2c_seq_item::type_id::create("tr");
    start_item(tr);
    tr.op = I2C_RESET;
    `uvm_info(get_type_name(), "RESET -> DUT Reset Issued", UVM_LOW);
    finish_item(tr);
  endtask
endclass

`endif
