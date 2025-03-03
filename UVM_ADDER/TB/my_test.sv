class my_test extends uvm_test;

        `uvm_component_utils(my_test);
        my_env env;

        //Constructor.
        function new (string name = "my_test", uvm_component parent);
        super.new(name,parent);
        `uvm_info("TEST","Connect Phase",UVM_HIGH);
        endfunction

        //Build phase 
        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            `uvm_info("TEST","Build Phase", UVM_HIGH);
            env = my_env :: type_id :: create("env",this);

        endfunction     

        //connect phase
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            `uvm_info("TEST","Connect Phase", UVM_HIGH);
        endfunction

        //run phase
        task run_phase(uvm_phase phase) ;
            
            super.run_phase(phase);
            phase.raise_objection(this);
            `uvm_info("TEST","Hello World",UVM_HIGH);
            phase.drop_objection(this);

        endtask //run_phass(uvn_phase phase)


endclass 
