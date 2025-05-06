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
  logic [7:0] addr_rw;
  bit [6:0] addr;
  bit rw;

  forever begin
    // انتظر إشارة START من الماستر
    vif.wait_start();
    @(posedge vif.scl_slave);

    // استقبل العنوان + R/W
    vif.recv_byte(addr_rw);
    addr = addr_rw[7:1];
    rw   = addr_rw[0];

    fork
  begin
    @(negedge vif.scl_slave);
    vif.sda_en    = 1;
    vif.sda_drive = 0;
    @(posedge vif.scl_slave);
    $display("[DRV_SLAVE] Sent ACK for Address = 0x%0h", addr);
    @(negedge vif.scl_slave);
    vif.sda_en    = 0;
    vif.sda_drive = 1;
  end
join


    if (rw == 0) begin
      // ------------------- WRITE -------------------
      logic [7:0] wdata;
      @(posedge vif.scl_slave);
      @(posedge vif.scl_slave);
      vif.recv_byte(wdata);

      // جهّز ACK للبيانات
      @(negedge vif.scl_slave);
      vif.sda_en    = 1;
      vif.sda_drive = 0;

      @(posedge vif.scl_slave);
      $display("[DRV_SLAVE] Sent ACK for DATA = 0x%0h", wdata);

      @(negedge vif.scl_slave);
      vif.sda_en    = 0;
      vif.sda_drive = 1;

      // احفظ البيانات
      vif.memory[addr] = wdata;
      `uvm_info(get_type_name(), $sformatf("SLAVE WRITE -> Addr: 0x%0h, Data: 0x%0h", addr, wdata), UVM_LOW);

    end else begin
      // ------------------- READ -------------------
      logic [7:0] rdata = vif.memory.exists(addr) ? vif.memory[addr] : 8'h00;

      @(posedge vif.scl_slave); // Sync before sending data bits
      vif.slave_respond_byte(rdata);

     
      vif.wait_nack();
      `uvm_info(get_type_name(), $sformatf("SLAVE READ -> Addr: 0x%0h, Data: 0x%0h", addr, rdata), UVM_LOW);
    end

    vif.wait_stop();
  end
endtask

endclass


`endif