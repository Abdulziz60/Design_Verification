//============================================================
// File: i2c_monitor_master.sv
// Description: Master monitor for I2C
//============================================================

`ifndef I2C_MONITOR_MASTER_SV
`define I2C_MONITOR_MASTER_SV

class i2c_monitor_master extends uvm_monitor;
  `uvm_component_utils(i2c_monitor_master)

  virtual i2c_if vif;
  uvm_analysis_port#(i2c_seq_item) ap;

  logic [7:0] wdata;
  logic [7:0] addr_rw;
  logic [7:0] rdata;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual Interface not set for Master Monitor");
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      i2c_seq_item tr;
      tr = i2c_seq_item::type_id::create("tr");

      // Wait for START
      vif.wait_start();
      @(posedge vif.clk);

      // Send or receive based on master action
      
      vif.recv_byte(addr_rw);
      tr.address = addr_rw[7:1];
      tr.op = addr_rw[0] ? I2C_READ : I2C_WRITE;

      if (tr.op == I2C_WRITE) begin
        
        vif.recv_byte(wdata);
        tr.data = wdata;
      end else begin
        
        vif.recv_byte(rdata);
        tr.data = rdata;
      end

      vif.wait_stop();
      ap.write(tr);

      `uvm_info(get_type_name(), $sformatf("MON_MASTER: Observed transaction: addr=0x%0h, data=0x%0h, op=%s",
                  tr.address, tr.data, tr.op.name()), UVM_LOW);
    end
  endtask
endclass

`endif