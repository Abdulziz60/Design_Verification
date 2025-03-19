import uvm_pkg::*;
`include "uvm_macros.svh"

class hello_test extends uvm_test;

    `uvm_component_utils(hello_test);
    hello_env  hello_env_inst;


    //Constructor.
    function new (string name = "hello_test", uvm_component parent);
    super.new(name,parent);
    `uvm_info("TEST","Connect Phase",UVM_LOW);
    endfunction

    

    //Build phase 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("TEST","Build Phase", UVM_MEDIUM);
        // hello_env_inst = new();
        hello_env_inst = hello_env :: type_id :: create ("hello_env_inst",this); // factory
    endfunction     

    //connect phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("TEST","Connect Phase", UVM_MEDIUM);
    endfunction

    //run phase
    task run_phase(uvm_phase phase) ;
        super.run_phase(phase);
        `uvm_info("TEST","run phase ", UVM_MEDIUM);
        
        phase.raise_objection(this);
        `uvm_info("TEST","Hello World", UVM_MEDIUM);

        #10;

        `uvm_info("TEST","Hello new World", UVM_MEDIUM);
        phase.drop_objection(this);
        
        

    endtask //run_phass(uvn_phase phase)

endclass 
