
class slave_sequencer extends uvm_sequencer#(i2c_sequence_item);
    `uvm_component_utils(slave_sequencer)

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
    function new(string name = "slave_sequencer", uvm_component parent);
        super.new(name, parent);
        `uvm_info("slave_sequencer CLASS", "Inside Constructor !", UVM_HIGH)
    endfunction

  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("slave_sequencer CLASS", "Build Phase!", UVM_HIGH)


    endfunction

    //--------------------------------------------------------
    //Connect Phase
    //--------------------------------------------------------
    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("slave_sequencer CLASS", "Connect Phase!", UVM_HIGH)

    endfunction

    
endclass