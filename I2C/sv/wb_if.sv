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
