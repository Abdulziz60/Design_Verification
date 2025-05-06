`ifndef I2C_TEST_PLAN_SEQ_SV
`define I2C_TEST_PLAN_SEQ_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class i2c_test_plan_seq extends uvm_sequence #(i2c_seq_item);
  `uvm_object_utils(i2c_test_plan_seq)

  int manual_txn_count = 0;
  int random_txn_count = 0;
  int total;

  function new(string name = "i2c_test_plan_seq");
    super.new(name);
  endfunction

  virtual task body();
    i2c_seq_item wr, rd;

    // Step 1: Master write to 0x55 with 0xAA
    wr = i2c_seq_item::type_id::create("custom_wr_55");
    start_item(wr);
    wr.address = 7'h55;
    wr.data    = 8'hAA;
    wr.op      = I2C_WRITE;
    finish_item(wr);
    manual_txn_count++;

    // Step 2: Master read from 0x55
    rd = i2c_seq_item::type_id::create("custom_rd_55");
    start_item(rd);
    rd.address = 7'h55;
    rd.op      = I2C_READ;
    finish_item(rd);
    manual_txn_count++;

    total = manual_txn_count;
    `uvm_info(get_type_name(),
      $sformatf("\n--- I2C Test Summary ---\n  Manual Transactions  : %0d\n  Random Transactions  : %0d\n  Total Executed       : %0d",
                manual_txn_count, random_txn_count, total), UVM_LOW)
  endtask

endclass

`endif
