import uvm_pkg::*;
`include "uvm_macros.svh"

class adder_env extends uvm_env #(adder_env);
    `uvm_component_utils(adder_env);

    adder_driver driver;
    adder_seqr seqr;

    function new (string name = "adder_env", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(),"Constructor", UVM_LOW);        
    endfunction


    function void build_phase(uvm_phase phase);
         super.build_phase(phase);
        `uvm_info(get_type_name(),"Build Phase", UVM_LOW);

        driver = adder_driver::type_id::create("driver",this);
        seqr = adder_seqr::type_id::create("seqr",this);
       

    endfunction


     function void connect_phase(uvm_phase phase);
         super.connect_phase(phase);
        `uvm_info(get_type_name(),"connect_phase", UVM_LOW);

        driver.seq_item_port.connect(seqr.seq_item_export);

    endfunction


    // task run_phase (uvm_phase phase);
    //     super.run_phase(phase);
    //     `uvm_info(get_type_name(), "Run Phase!", UVM_LOW);

    //     forever begin 
            
            


    //     end
    // endtask
    
endclass //adder_driver 