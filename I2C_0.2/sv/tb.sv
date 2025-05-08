class i2c_tb extends uvm_env;
  `uvm_component_utils(i2c_tb)
    i2c_env env;
    scoreboard   sb;

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "i2c_tb", uvm_component parent);
    super.new(name, parent);
    `uvm_info("i2c_tb  CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction

  
  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("i2c_tb CLASS", "Build Phase!", UVM_HIGH)
    
    env = i2c_env::type_id::create("env", this);
    sb = scoreboard::type_id::create("sb", this);

  endfunction

  
  //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("i2c_tb CLASS", "Connect Phase!", UVM_HIGH)

    env.MA.m_monitor.analysis_port.connect(sb.analysis_export);
  endfunction

  
  //--------------------------------------------------------
  //Run Phase
  //--------------------------------------------------------
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("TEST_CLASS", "Run Phase!", UVM_HIGH)

    
  endtask
endclass