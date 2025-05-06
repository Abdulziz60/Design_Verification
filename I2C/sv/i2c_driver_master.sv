//============================================================
// File: i2c_driver_master.sv
// Description: Master driver for I2C
//============================================================

`ifndef I2C_DRIVER_MASTER_SV
`define I2C_DRIVER_MASTER_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

class i2c_driver_master extends uvm_driver #(i2c_seq_item);
  `uvm_component_utils(i2c_driver_master)

  virtual i2c_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual Interface not set for Master Driver");
  endfunction

  virtual task run_phase(uvm_phase phase);
    i2c_seq_item tr;
    forever begin
      seq_item_port.get_next_item(tr);
      case (tr.op)
        I2C_RESET: begin
          `uvm_info(get_type_name(), "RESET issued to DUT", UVM_MEDIUM);
          vif.rst_n <= 0;
          repeat (3) @(posedge vif.clk);
          vif.rst_n <= 1;
        end
        I2C_WRITE: begin
          vif.send_start();
          vif.send_byte({tr.address, 1'b0});
          // vif.wait_ack(); // Master waits for ACK
          vif.send_byte(tr.data);
          // vif.wait_ack();
          vif.send_stop();
        end
        I2C_READ: begin
          vif.send_start();
          vif.send_byte({tr.address, 1'b1});
          // vif.wait_ack();
          vif.recv_byte(tr.read_data);
          vif.send_nack();
          vif.send_stop();
        end
      endcase
      seq_item_port.item_done();
    end
  endtask
endclass

`endif