// yapp_tx_driver.sv
`timescale 1ns/1ps
import uvm_pkg::*;
`include "uvm_macros.svh"

class yapp_tx_driver extends uvm_driver #(yapp_packet);
  `uvm_component_utils(yapp_tx_driver)

  function new(string name = "yapp_tx_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    yapp_packet pkt;
    forever begin
      seq_item_port.get_next_item(pkt);
      send_to_dut(pkt);
      seq_item_port.item_done();
    end
  endtask

  // Task to simulate sending packet to DUT (printing only)
  virtual task send_to_dut(yapp_packet pkt);
    `uvm_info(get_type_name(), $sformatf("Packet is \n%s", pkt.sprint()), UVM_LOW)
    #10ns; // small delay for easier debug visibility
  endtask

endclass
