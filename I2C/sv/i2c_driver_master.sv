`ifndef I2C_DRIVER_MASTER_SV
`define I2C_DRIVER_MASTER_SV


`include "uvm_macros.svh"
import uvm_pkg::*;

// `include "i2c_seq_item.sv"

class i2c_driver_master extends uvm_driver #(i2c_seq_item);
  `uvm_component_utils(i2c_driver_master)

  virtual wb_if vif; // Virtual interface to Wishbone


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual wb_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual Interface must be set for driver")
  endfunction

  task run_phase(uvm_phase phase);
    i2c_seq_item req;

    `uvm_info(get_type_name(), "Driver Started", UVM_LOW)

    forever begin
    
      seq_item_port.get_next_item(req);

      `uvm_info(get_type_name(), $sformatf("Driving: addr=0x%0h, data=0x%0h, rw=%0b", req.address, req.data, req.rw), UVM_LOW)

      // Set signals before asserting stb and cyc
      vif.addr  <= req.address;
      vif.wdata <= req.data;
      vif.we    <= (req.rw == 0); // 0 = write, 1 = read
      vif.cyc   <= 1;
      vif.stb   <= 1;

      // Wait for ack
      @(posedge vif.clk);
      wait (vif.ack == 1);

      // If it's read, capture the read data
      if (req.rw == 1) begin
        req.data = vif.rdata;
      end

      // Deassert control signals after ack
      @(posedge vif.clk);
      vif.cyc <= 0;
      vif.stb <= 0;
      vif.addr <= '0;
      vif.wdata <= '0;
      vif.we <= '0;

      // Let things settle for a cycle
      @(posedge vif.clk);

      seq_item_port.item_done();
    end
  endtask

endclass

`endif