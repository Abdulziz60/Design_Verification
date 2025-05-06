`ifndef I2C_TRANSACTION_SV
`define I2C_TRANSACTION_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

// Enumeration for operation types
typedef enum { I2C_WRITE, I2C_READ, I2C_RESET } i2c_op_t;

class i2c_seq_item extends uvm_sequence_item;
  `uvm_object_utils(i2c_seq_item)

  rand bit [6:0] address;
  rand bit [7:0] data;
  bit [7:0] read_data;
  rand i2c_op_t op;

  function new(string name = "i2c_seq_item");
    super.new(name);
  endfunction

  function bit is_read();
    return (op == I2C_READ);
  endfunction

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field("address", address, 7);
    printer.print_field("data", data, 8);
    printer.print_field("read_data", read_data, 8);
    printer.print_string("op", op.name());
  endfunction
endclass


`endif