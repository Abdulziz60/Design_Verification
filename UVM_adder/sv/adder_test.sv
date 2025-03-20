import uvm_pkg::*;
`include "uvm_macros.svh"

class adder_test extends uvm_test;

    `uvm_component_utils(adder_test);
    adder_env env;
    adder_seq seq;

    //Constructor.
    function new (string name = "adder_test", uvm_component parent);
    super.new(name,parent);
    `uvm_info(get_type_name(),"Connect Phase",UVM_LOW);
    endfunction

    

    //Build phase 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(),"Build Phase", UVM_LOW);

        
        env = adder_env::type_id::create("env", this);
        
    endfunction     

    //connect phase
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(),"Connect Phase", UVM_LOW);
    endfunction

    //run phase
    task run_phase(uvm_phase phase) ;
        super.run_phase(phase);
        `uvm_info(get_type_name(),"run phase ", UVM_LOW);

        seq = adder_seq::type_id::create("seq");

        phase.raise_objection(this);

        seq.start(env.seqr);
        
        phase.drop_objection(this);  

    endtask //run_phass(uvn_phase phase)

endclass 
