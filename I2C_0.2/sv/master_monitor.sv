
class master_monitor extends uvm_monitor;
    `uvm_component_utils(master_monitor)
    virtual i2c_if vif;
    i2c_sequence_item item;
    uvm_analysis_port #(i2c_sequence_item) analysis_port;


  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
    function new(string name = "master_monitor", uvm_component parent);
        super.new(name, parent);
        `uvm_info("master_monitor CLASS", "Inside Constructor !", UVM_HIGH)
        analysis_port = new("analysis_port", this);
    endfunction

  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("master_monitor CLASS", "Build Phase!", UVM_HIGH)
      if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "vif not received in master monitor")
    else
      `uvm_info(get_type_name(), "vif received in master monitor", UVM_LOW)
    endfunction

    //--------------------------------------------------------
    //Connect Phase
    //--------------------------------------------------------
    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("master_monitor CLASS", "Connect Phase!", UVM_HIGH)

    endfunction

    //--------------------------------------------------------
    //Run Phase
    //--------------------------------------------------------
    task run_phase (uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("master_monitor CLASS", "Run Phase!", UVM_HIGH)

      // Example only: send dummy data
      
      item = i2c_sequence_item::type_id::create("item");
      item.addr     = 8'h10;
      item.data_in  = 8'hA5;
      // إرسال إلى scoreboard
      analysis_port.write(item);

      `uvm_info(get_type_name(), "Sent transaction to scoreboard", UVM_MEDIUM)
    endtask
endclass