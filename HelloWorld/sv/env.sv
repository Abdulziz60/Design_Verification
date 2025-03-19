import uvm_pkg::*;
`include "uvm_macros.svh"

class hello_env extends uvm_env;
    `uvm_component_utils(hello_env);

    // Constructor.
    function new (string name = "hello_env", uvm_component parent);
        super.new(name,parent);
        `uvm_info("ENV: ","Connect Phase",UVM_LOW);
    endfunction

    // build phase
    function void build_phase(uvm_phase Phase);
        super.build_phase(Phase);
        `uvm_info("ENV: ","build phase",UVM_MEDIUM);
    endfunction
    
    // connect phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("ENV: ", "connect phase",UVM_MEDIUM);
    endfunction

    //run phase
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("ENV: ", "Run Phase",UVM_MEDIUM);
    endtask //run_phass(uvn_phase phase)

endclass 
