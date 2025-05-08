
class slave_agent extends uvm_agent;
    `uvm_component_utils(slave_agent)
    slave_sequencer s_sequencer;
    slave_driver    s_driver;
    slave_monitor   s_monitor;

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
    function new(string name = "slave_agent", uvm_component parent);
        super.new(name, parent);
        `uvm_info("slave_agent CLASS", "Inside Constructor !", UVM_HIGH)
    endfunction

  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("slave_agent CLASS", "Build Phase!", UVM_HIGH)
      s_sequencer = slave_sequencer::type_id::create("sequencer", this);
      s_driver    = slave_driver::type_id::create("driver", this);
      s_monitor   = slave_monitor::type_id::create("monitor", this);
    endfunction

    //--------------------------------------------------------
    //Connect Phase
    //--------------------------------------------------------
    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("slave_agent CLASS", "Connect Phase!", UVM_HIGH)
      
    endfunction

    //--------------------------------------------------------
    //Run Phase
    //--------------------------------------------------------
    task run_phase (uvm_phase phase);
      super.run_phase(phase);
    //   `uvm_info("slave_agent CLASS", "Run Phase!", UVM_HIGH)


    endtask
endclass