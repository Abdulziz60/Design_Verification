
`ifndef YAPP_PKG_SV
`define YAPP_PKG_SV

// Import UVM base classes and macros
import uvm_pkg::*;
`include "uvm_macros.svh"

package yapp_pkg;

  // Include the yapp_packet definition inside the package
  `include "/home/Abdulaziz_Salem/CX-301-DesignVerification/Labs/Lab7/task1_data/sv/yapp_packet.sv"

endpackage

`endif
