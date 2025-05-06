//============================================================
// File: i2c_driver_slave.sv
// Description: Slave driver for I2C
//============================================================

`ifndef I2C_DRIVER_SLAVE_SV
`define I2C_DRIVER_SLAVE_SV
`include "uvm_macros.svh"
import uvm_pkg::*;

class i2c_driver_slave extends uvm_driver #(i2c_seq_item);
  `uvm_component_utils(i2c_driver_slave)

  virtual i2c_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual Interface not set for Slave Driver");
  endfunction

  virtual task run_phase(uvm_phase phase);
    i2c_seq_item tr;
    logic [7:0] addr_rw;
    bit [6:0] addr;
    bit rw;

    forever begin
      seq_item_port.get_next_item(tr);
      vif.wait_start();
      @(posedge vif.scl_slave);

      vif.recv_byte(addr_rw);  // Proper byte receive
      addr = addr_rw[7:1];
      rw   = addr_rw[0];

      if (addr != tr.address) begin
        vif.send_nack();
        seq_item_port.item_done();
        continue;
      end

      vif.send_ack();

      if (rw == 0) begin
        logic [7:0] wdata;
        @(posedge vif.scl_slave);
        vif.recv_byte(wdata);
        vif.memory[addr] = wdata;
        vif.send_ack();
        `uvm_info(get_type_name(), $sformatf("SLAVE WRITE -> Addr: 0x%0h, Data: 0x%0h", addr, wdata), UVM_LOW);
      end else begin
        logic [7:0] rdata = vif.memory.exists(addr) ? vif.memory[addr] : 8'h00;
        @(posedge vif.scl_slave);
        vif.slave_respond_byte(rdata);
        vif.wait_nack();
        `uvm_info(get_type_name(), $sformatf("SLAVE READ -> Addr: 0x%0h, Data: 0x%0h", addr, rdata), UVM_LOW);
      end

      vif.wait_stop();
      seq_item_port.item_done();
    end
  endtask
endclass

`endif