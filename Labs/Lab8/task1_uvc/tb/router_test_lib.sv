

`include "uvm_macros.svh"
import uvm_pkg::*;
import yapp_pkg::*;

class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  yapp_env env;

  function new(string name = "base_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Configure sequencer to run yapp_5_packets sequence
    uvm_config_db#(uvm_object_wrapper)::set(this, 
                                            "env.agent.sequencer.run_phase", 
                                            "default_sequence", 
                                            yapp_5_packets::get_type());

    env = yapp_env::type_id::create("env", this);
  endfunction

endclass
