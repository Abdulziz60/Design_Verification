
class master_agent extends uvm_agent;
    `uvm_component_utils(master_agent)

    master_sequencer m_sequencer;
    master_driver    m_driver;
    master_monitor   m_monitor;

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
    function new(string name = "master_agent", uvm_component parent);
        super.new(name, parent);
        `uvm_info("master_agent CLASS", "Inside Constructor !", UVM_HIGH)
    endfunction

  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("master_agent CLASS", "Build Phase!", UVM_HIGH)
      m_sequencer = master_sequencer::type_id::create("sequencer", this);
      m_driver    = master_driver::type_id::create("driver", this);
      m_monitor   = master_monitor::type_id::create("monitor", this);

    endfunction

    //--------------------------------------------------------
    //Connect Phase
    //--------------------------------------------------------
    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("master_agent CLASS", "Connect Phase!", UVM_HIGH)

    endfunction

    //--------------------------------------------------------
    //Run Phase
    //--------------------------------------------------------
    task run_phase (uvm_phase phase);
      super.run_phase(phase);
    //   `uvm_info("master_agent CLASS", "Run Phase!", UVM_HIGH)


    endtask
endclass