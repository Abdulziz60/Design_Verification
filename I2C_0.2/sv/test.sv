
class i2c_test extends uvm_test;
  `uvm_component_utils(i2c_test)

  i2c_tb tb;
  i2c_sequence_item i2c_seq_item;
  i2c_sequence i2c_seq; 
  virtual i2c_if vif;

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
  function new(string name = "i2c_test", uvm_component parent);
    super.new(name, parent);
    `uvm_info("TEST_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction

  
  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TEST_CLASS", "Build Phase!", UVM_HIGH)

    tb = i2c_tb::type_id::create("tb", this);
    i2c_seq_item = i2c_sequence_item::type_id::create("i2c_seq_item", this);
    i2c_seq = i2c_sequence::type_id::create("i2c_sequence", this );

    
        if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
          `uvm_fatal("NOVIF", "virtual interface not set for vif")
        uvm_config_db#(virtual i2c_if)::set(this, "env.*", "vif", vif);
  endfunction

  
  //--------------------------------------------------------
  //Connect Phase
  //--------------------------------------------------------
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TEST_CLASS", "Connect Phase!", UVM_HIGH)

  endfunction

  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction
  
  //--------------------------------------------------------
  //Run Phase
  //--------------------------------------------------------
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("TEST_CLASS", "Run Phase!", UVM_HIGH)

    phase.raise_objection(this);

    i2c_seq.start(tb.env.MA.m_sequencer);

    #100;
    phase.drop_objection(this);
    
  endtask
endclass