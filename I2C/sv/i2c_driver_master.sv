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
  logic [7:0] rdata;

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
          @(posedge vif.clk);
          if (vif.sda !== 0) begin
            `uvm_error(get_type_name(), "Slave did not ACK the address")
            vif.send_stop();
            seq_item_port.item_done();
            continue;
          end
        end

        I2C_READ: begin
          vif.send_start();
          vif.send_byte({tr.address, 1'b1});  // استخدم RW = 1

          @(posedge vif.clk);
          if (vif.sda !== 0) begin
            `uvm_error(get_type_name(), "Slave did not ACK the address")
            vif.send_stop();
            seq_item_port.item_done();
            continue;
          end

          
          vif.recv_byte(rdata);
          tr.data = rdata;

          vif.send_nack();
          vif.send_stop();
          `uvm_info(get_type_name(), $sformatf("READ DONE: Addr=0x%0h, Data=0x%0h", tr.address, tr.data), UVM_MEDIUM);
        end
      endcase
      seq_item_port.item_done();
    end
  endtask
endclass

`endif