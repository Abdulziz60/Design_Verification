
package i2c_packet;

  // Import UVM base classes and macros
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // Core transaction and sequence
  `include "../sv/i2c_sequence_item.sv"        
  `include "../sv/i2c_sequence.sv"             

  // Master-side components
  `include "../sv/master_driver.sv"
  `include "../sv/master_monitor.sv"
  `include "../sv/master_sequencer.sv"
  `include "../sv/master_agent.sv"

  // Slave-side components
  `include "../sv/slave_driver.sv"
  `include "../sv/slave_monitor.sv"
  `include "../sv/slave_sequencer.sv"
  `include "../sv/slave_agent.sv"

  // Environment and infrastructure
  `include "../sv/scoreboard.sv"
  `include "../sv/env.sv"
  `include "../sv/test.sv"

endpackage


