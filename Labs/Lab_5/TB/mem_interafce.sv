`timescale 1ns/1ps

interface mem_if;

    logic       clk;
    logic         we ;
    logic [4:0] addr ;
    logic [7:0] din  ;
    logic [7:0] dout ;

modport DUT  (input clk, input we, input addr, input din, output dout);
modport TEST (input clk, output we, output addr, output din, input dout);

endinterface