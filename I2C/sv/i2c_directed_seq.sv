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

    // Write transaction
    wr = i2c_seq_item::type_id::create("wr_txn");
    start_item(wr);
    wr.address = 7'h08;    // I2C Address (check your slave responds to this)
    wr.data    = 8'hA5;    // Example data
    wr.op      = I2C_WRITE;
    finish_item(wr);

    `uvm_info(get_type_name(), $sformatf("Started WRITE: addr=0x%0h, data=0x%0h", wr.address, wr.data), UVM_MEDIUM)

    // Read transaction
    rd = i2c_seq_item::type_id::create("rd_txn");
    start_item(rd);
    rd.address = 7'h08;    // Same address as above
    rd.op      = I2C_READ;
    finish_item(rd);

    `uvm_info(get_type_name(), $sformatf("Started READ: addr=0x%0h", rd.address), UVM_MEDIUM)
  endtask

endclass
`endif