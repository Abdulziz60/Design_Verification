// Code your testbench here
// or browse Examples
timeunit 1ns;
timeprecision 1ns;

`include "../task2/mem.sv"
`include "../task2/TB_mem.sv"

module top;
  
  logic      clk;
  logic      rst_n;
  logic      read;
  logic      write;
  logic [4:0]addr;
  logic [7:0]data_i;
  logic [7:0]data_o;
  logic      ack;
  
  initial clk = 0;
  always #5 clk = ~clk;
  
  mem DUT_mem(.*);
  
  TB_mem DUT_TB_mem(.*);
  
  
 
  
  
  
endmodule