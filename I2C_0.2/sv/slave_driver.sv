
class slave_driver extends uvm_driver#(i2c_sequence_item);
    `uvm_component_utils(slave_driver)
    virtual i2c_if vif;

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
    function new(string name = "slave_driver", uvm_component parent);
        super.new(name, parent);
        `uvm_info("slave_driver CLASS", "Inside Constructor !", UVM_HIGH)
    endfunction

  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("slave_driver CLASS", "Build Phase!", UVM_HIGH)

      if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
       `uvm_fatal(get_type_name(), "vif not received in slave driver")
      else
       `uvm_info(get_type_name(), "vif received in slave driver", UVM_LOW)
    endfunction

    //--------------------------------------------------------
    //Connect Phase
    //--------------------------------------------------------
    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("slave_driver CLASS", "Connect Phase!", UVM_HIGH)

    endfunction

    //--------------------------------------------------------
    //Run Phase
    //--------------------------------------------------------
    task run_phase (uvm_phase phase);
      super.run_phase(phase);
    //   `uvm_info("slave_driver CLASS", "Run Phase!", UVM_HIGH)


    endtask
endclass