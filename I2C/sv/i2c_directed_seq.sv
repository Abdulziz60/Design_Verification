`ifndef I2C_DIRECTED_SEQ_SV
`define I2C_DIRECTED_SEQ_SV

`include "uvm_macros.svh"
import uvm_pkg::*;


class i2c_directed_seq extends uvm_sequence #(i2c_seq_item);
  `uvm_object_utils(i2c_directed_seq)

  function new(string name = "i2c_directed_seq");
    super.new(name);
  endfunction

  virtual task body();
    i2c_seq_item wr, rd;

    // Example 1: Write to address 0x10, data 0xAB
    wr = i2c_seq_item::type_id::create("wr_txn_0");
    start_item(wr);
    wr.address = 7'h10;
    wr.data = 8'hAB;
    wr.op = I2C_WRITE;
    finish_item(wr);

    // Example 2: Read from address 0x10
    rd = i2c_seq_item::type_id::create("rd_txn_0");
    start_item(rd);
    rd.address = 7'h10;
    rd.op = I2C_READ;
    finish_item(rd);
  endtask

endclass
`endif