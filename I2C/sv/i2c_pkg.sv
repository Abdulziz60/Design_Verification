
`ifndef I2C_PKG_SV
`define I2C_PKG_SV

// Import UVM base classes and macros
import uvm_pkg::*;
`include "uvm_macros.svh"

package i2c_packet;

  // Core transaction and sequence
  `include "../sv/i2c_seq_item.sv"        // Transaction item class
  `include "../sv/i2c_seq.sv"             // Master sequence
  `include "../sv/i2c_directed_seq.sv"
  `include "../sv/i2c_test_plan_seq.sv"

  // Master-side components
  `include "../sv/i2c_driver_master.sv"
  `include "../sv/i2c_monitor_master.sv"
  `include "../sv/i2c_sequencer_master.sv"
  `include "../sv/i2c_agent_master.sv"

  // Slave-side components
  `include "../sv/i2c_driver_slave.sv"
  `include "../sv/i2c_monitor_slave.sv"
  `include "../sv/i2c_sequencer_slave.sv"
  `include "../sv/i2c_agent_slave.sv"

  // Environment and infrastructure
  `include "../sv/i2c_scoreboard.sv"
  `include "../sv/i2c_env.sv"
  `include "../sv/i2c_test.sv"

endpackage

`endif


// `ifndef I2C_PKG_SV
// `define I2C_PKG_SV

// // Import UVM base classes and macros
// import uvm_pkg::*;
// `include "uvm_macros.svh"

// package i2c_packet;

//   // Include all I2C-related files inside the package

//   `include "../sv/i2c_seq_item.sv"      // Transaction class
//   `include "../sv/i2c_seq.sv"           // Sequence class
//   `include "../sv/i2c_driver.sv"        // Driver
//   `include "../sv/i2c_monitor.sv"       // Monitor
//   `include "../sv/i2c_agent_master.sv"  // Master Agent
//   `include "../sv/i2c_agent_slave.sv"   // Slave Agent (Dummy Mode)
//   `include "../sv/i2c_scoreboard.sv"    // Scoreboard
//   `include "../sv/i2c_env.sv"           // Environment
//   `include "../sv/i2c_test.sv"          // Test

// endpackage

// `endif