/*
// Define your enumerated type(s) here

class yapp_packet extends uvm_sequence_item;

// Follow the lab instructions to create the packet.
// Place the packet declarations in the following order:

  // Define protocol data

  // Define control knobs

  // Enable automation of the packet's fields

  // Define packet constraints

  // Add methods for parity calculation and class construction

endclass: yapp_packet
*/

`ifndef YAPP_PACKET_SV
`define YAPP_PACKET_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

// Enum for parity control
typedef enum {GOOD_PARITY, BAD_PARITY} parity_type_e;

class yapp_packet extends uvm_sequence_item;

  // === Protocol Data ===
  rand bit [1:0] addr;               // 2-bit address (0-2 valid)
  rand bit [5:0] length;             // 6-bit payload length (1-63)
  rand byte payload[];              // Variable payload
       byte parity;                 // Even parity (XOR of header + payload)

  // === Control Knobs ===
  rand parity_type_e parity_type;   // GOOD or BAD parity
  rand int packet_delay;            // delay (1~20 cycles)

  // === Automation ===
  `uvm_object_utils_begin(yapp_packet)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_int(length, UVM_ALL_ON)
    `uvm_field_array_int(payload, UVM_ALL_ON)
    `uvm_field_int(parity, UVM_ALL_ON)
    `uvm_field_enum(parity_type_e, parity_type, UVM_ALL_ON)
    `uvm_field_int(packet_delay, UVM_ALL_ON)
  `uvm_object_utils_end

  // === Constructor ===
  function new(string name = "yapp_packet");
    super.new(name);
  endfunction

  // === Parity Calculation ===
  function byte calc_parity();
    byte p;
    p = {addr, length};  // Header is 1 byte
    foreach (payload[i])
      p ^= payload[i];
    return p;
  endfunction

  // === Set Parity Based on Type ===
  function void set_parity();
    if (parity_type == GOOD_PARITY)
      parity = calc_parity();
    else
      parity = ~calc_parity(); // Force incorrect value
  endfunction

  // === post_randomize Hook ===
  function void post_randomize();
    set_parity();
  endfunction

  // === Constraints ===
  constraint addr_c { addr inside {[0:2]}; } // 3 is illegal
  constraint length_c {
    length inside {[1:63]};
    payload.size() == length;
  }
  constraint parity_type_dist_c {
    parity_type dist {GOOD_PARITY := 5, BAD_PARITY := 1};
  }
  constraint delay_c {
    packet_delay inside {[1:20]};
  }

endclass : yapp_packet

`endif
