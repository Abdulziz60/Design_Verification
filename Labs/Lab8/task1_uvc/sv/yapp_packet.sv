// yapp_packet.sv
`timescale 1ns/1ps
import uvm_pkg::*;
`include "uvm_macros.svh"

class yapp_packet extends uvm_sequence_item;
  `uvm_object_utils(yapp_packet)

  rand bit [7:0] data;
  rand bit [3:0] addr;
  rand bit       valid;

  function new(string name = "yapp_packet");
    super.new(name);
  endfunction

  constraint addr_limit {
    addr < 10;
  }

  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("data",  data,  8);
    printer.print_field_int("addr",  addr,  4);
    printer.print_field_int("valid", valid, 1);
  endfunction

endclass
