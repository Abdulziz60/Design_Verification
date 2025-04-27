`ifndef I2C_SEQ_ITEM_SV
`define I2C_SEQ_ITEM_SV

import uvm_pkg::*;
`include "uvm_macros.svh"


class i2c_seq_item extends uvm_sequence_item;

  rand bit [6:0] address;
  rand bit rw;
  rand bit [7:0] data;
  rand bit start;
  rand bit stop;
  rand bit repeated_start;
  rand bit ack;
  rand bit valid;

  `uvm_object_utils(i2c_seq_item)

  function new(string name = "i2c_seq_item");
    super.new(name);
  endfunction

  constraint legal_values {
    address inside {[0:127]};
    rw inside {0,1};
    ack inside {0,1};
  }

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field("address", address, 7);
    printer.print_field("rw", rw, 1);
    printer.print_field("data", data, 8);
    printer.print_field("start", start, 1);
    printer.print_field("stop", stop, 1);
    printer.print_field("repeated_start", repeated_start, 1);
    printer.print_field("ack", ack, 1);
    printer.print_field("valid", valid, 1);
  endfunction

endclass

`endif