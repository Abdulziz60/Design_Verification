
class i2c_env extends uvm_env;
    `uvm_component_utils(i2c_env)
    master_agent MA;
    slave_agent  SA;

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
    function new(string name = "i2c_env", uvm_component parent);
        super.new(name, parent);
        `uvm_info("ENV_CLASS", "Inside Constructor !", UVM_HIGH)
    endfunction

  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("ENV_CLASS", "Build Phase!", UVM_HIGH)
      MA = master_agent::type_id::create("MA", this);
      SA = slave_agent::type_id::create("SA", this);


    endfunction

    //--------------------------------------------------------
    //Connect Phase
    //--------------------------------------------------------
    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("ENV_CLASS", "Connect Phase!", UVM_HIGH)

      
    endfunction

    //--------------------------------------------------------
    //Run Phase
    //--------------------------------------------------------
    task run_phase (uvm_phase phase);
      super.run_phase(phase);
    //   `uvm_info("TEST_CLASS", "Run Phase!", UVM_HIGH)


    endtask
endclass