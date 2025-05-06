//----------------------------------------------------------------------
// Interface: wb_if
//
// Description:
//   This interface defines a WISHBONE-compatible bus used to connect
//   the I2C Master design to a bus-based system environment.
//
// Ports:
//   - clk     : Clock signal (input only).
//   - rst_n   : Active-low synchronous reset.
//   - cyc     : Cycle valid signal (indicates valid bus cycle).
//   - stb     : Strobe signal (indicates valid transfer).
//   - we      : Write enable (1 = write, 0 = read).
//   - addr    : 7-bit address signal.
//   - wdata   : 8-bit data to be written to the slave.
//   - rdata   : 8-bit data read from the slave.
//   - ack     : Acknowledge signal from the slave.
//
// Purpose:
//   Used as the virtual interface in the UVM testbench to drive and
//   monitor transactions between the testbench and the DUT.
//
// Usage:
//   Bind this interface to the DUT and pass it to UVM components
//   (like drivers and monitors) through configuration database or
//   constructor arguments.
//
//----------------------------------------------------------------------

`ifndef WB_IF_SV
`define WB_IF_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

interface wb_if(input logic clk);

  logic        rst_n;
  logic        cyc;
  logic        stb;
  logic        we;
  logic [6:0]  addr;
  logic [7:0]  wdata;
  logic [7:0]  rdata;
  logic        ack;

endinterface

`endif
