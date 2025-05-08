

class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)

    uvm_analysis_imp #(i2c_sequence_item, scoreboard) analysis_export;

  //--------------------------------------------------------
  //Constructor
  //--------------------------------------------------------
    function new(string name = "scoreboard", uvm_component parent);
        super.new(name, parent);
        `uvm_info("scoreboard CLASS", "Inside Constructor !", UVM_HIGH)

        analysis_export = new("analysis_export", this);
    endfunction

  //--------------------------------------------------------
  //Build Phase
  //--------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("scoreboard CLASS", "Build Phase!", UVM_HIGH)


    endfunction

    //--------------------------------------------------------
    //Connect Phase
    //--------------------------------------------------------
    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      `uvm_info("scoreboard CLASS", "Connect Phase!", UVM_HIGH)

    endfunction

    //--------------------------------------------------------
    //write Phase
    //--------------------------------------------------------
    function void write(input i2c_sequence_item item);
    `uvm_info(get_type_name(),
      $sformatf("Received transaction: addr=0x%0h, data_in=0x%0h",
                item.addr, item.data_in),
      UVM_MEDIUM)
  endfunction

    //--------------------------------------------------------
    //Run Phase
    //--------------------------------------------------------
    task run_phase (uvm_phase phase);
      super.run_phase(phase);
      `uvm_info("scoreboard CLASS", "Run Phase!", UVM_HIGH)
    endtask
endclass