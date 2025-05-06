//============================================================
// File: i2c_monitor_slave.sv
// Description: Slave monitor for I2C
//============================================================

`ifndef I2C_MONITOR_SLAVE_SV
`define I2C_MONITOR_SLAVE_SV

class i2c_monitor_slave extends uvm_monitor;
  `uvm_component_utils(i2c_monitor_slave)

  virtual i2c_if vif;
  uvm_analysis_port #(i2c_seq_item) ap;
  logic [7:0] addr_rw;
  logic [7:0] wdata;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", "Virtual Interface not set for Slave Monitor");
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      i2c_seq_item tr = i2c_seq_item::type_id::create("tr", this);
      vif.wait_start();
      @(posedge vif.scl_slave);

      // Receive address + R/W bit
      vif.recv_byte(addr_rw);
      tr.address = addr_rw[7:1];
      tr.op = addr_rw[0] ? I2C_READ : I2C_WRITE;

      if (tr.op == I2C_WRITE) begin
        @(posedge vif.scl_slave);
        vif.recv_byte(wdata);
        tr.data = wdata;
      end else begin
        logic [7:0] rdata = vif.memory.exists(tr.address) ? vif.memory[tr.address] : 8'h00;
        tr.data = rdata;
      end

      vif.wait_stop();
      ap.write(tr);

      `uvm_info(get_type_name(), $sformatf("SLAVE MONITOR -> Addr: 0x%0h, Data: 0x%0h, RW: %s",
                                           tr.address, tr.data,
                                           (tr.op == I2C_READ) ? "READ" : "WRITE"), UVM_LOW);
    end
  endtask
endclass

`endif
