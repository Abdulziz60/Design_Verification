`ifndef I2C_MONITOR_MASTER_SV
`define I2C_MONITOR_MASTER_SV

class i2c_monitor_master extends uvm_monitor;
  `uvm_component_utils(i2c_monitor_master)

  virtual wb_if vif;
  uvm_analysis_port #(i2c_seq_item) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "i2c_monitor_master build", UVM_LOW)
    if (!uvm_config_db#(virtual wb_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual Interface must be set for monitor")
  endfunction

  task run_phase(uvm_phase phase);
    i2c_seq_item trans;
    forever begin
      @(posedge vif.clk);
      if (vif.cyc && vif.stb && vif.ack) begin
        trans = i2c_seq_item::type_id::create("trans");
        trans.address = vif.addr;
        trans.data    = vif.rdata;
        trans.rw      = ~vif.we; // vif.we = 0: write, 1: read
        `uvm_info(get_type_name(), $sformatf("Monitor Captured: addr=0x%0h, data=0x%0h, rw=%0b", trans.address, trans.data, trans.rw), UVM_LOW)
        ap.write(trans);
      end
    end
  endtask

endclass




`endif