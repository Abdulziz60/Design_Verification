`ifndef I2C_TEST_SV
`define I2C_TEST_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "../sv/i2c_env.sv"

class i2c_test extends uvm_test;
  `uvm_component_utils(i2c_test)

  i2c_env env;
  i2c_seq seq;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = i2c_env::type_id::create("env", this);
  endfunction

task run_phase(uvm_phase phase);
  super.run_phase(phase);

  phase.raise_objection(this);

  `uvm_info(get_type_name(), "Starting I2C Test", UVM_LOW)

  seq = i2c_seq::type_id::create("seq");

  begin
    i2c_seq_item req;

    req = i2c_seq_item::type_id::create("manual_req1");
    req.address = 7'h10; req.data = 8'hA5; req.rw = 0; // Write
    seq.requests.push_back(req);

    req = i2c_seq_item::type_id::create("manual_req2");
    req.address = 7'h10; req.data = 8'hA5; req.rw = 1; // Read
    seq.requests.push_back(req);
  end

  seq.random_txn_count = 10; 

  seq.start(env.master_agent.sequencer);

  `uvm_info(get_type_name(), "I2C Test Completed", UVM_LOW)

  phase.drop_objection(this);
endtask

endclass

`endif

