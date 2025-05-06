//----------------------------------------------------------------------
// Class: i2c_test
//
// Description:
//   Top-level UVM test that instantiates the I2C verification environment
//   and initiates execution of the main test sequence `i2c_test_plan_seq`.
//
// Purpose:
//   - Acts as the main entry point for running the I2C testbench.
//   - Connects the environment and launches the functional test plan.
//
// Responsibilities:
//   - Creates the UVM environment (`i2c_env`) during the build phase.
//   - Starts the `i2c_test_plan_seq` sequence on the master agent's sequencer.
//   - Uses UVM objection mechanism to control the simulation phase duration.
//
// Notes:
//   - The test sequence includes both directed and random transactions.
//   - Logging is used to indicate start and end of test execution.
//
//----------------------------------------------------------------------


`ifndef I2C_TEST_SV
`define I2C_TEST_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "../sv/i2c_env.sv"
`include "../sv/i2c_directed_seq.sv"

class i2c_test extends uvm_test;
  `uvm_component_utils(i2c_test)

  i2c_env env;
  i2c_test_plan_seq plan_seq;

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

    `uvm_info(get_type_name(), "Starting i2c_test_plan_seq", UVM_LOW)
    plan_seq = i2c_test_plan_seq::type_id::create("plan_seq");
    plan_seq.random_txn_count = 10;
    plan_seq.start(env.master_agent.sequencer);

    `uvm_info(get_type_name(), "i2c_test_plan_seq Completed", UVM_LOW)
    phase.drop_objection(this);
  endtask
endclass

`endif

