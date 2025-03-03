class my_env extends uvm_env;

        `uvm_component_utils(my_env);

        //Constructor.
        function new (string name = "my_env", uvm_component parent);
        super.new(name,parent);
        `uvm_info("ENV: ", "Connect Phase",UVM_HIGH);
        endfunction


        //build phase
        function void build_phase(uvm_phase Phase);
            super.build_phase(Phase);
            `uvm_info("ENV: ","Run Phase",UVM_HIGH);
        endfunction
        
        //connect phase
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            `uvm_info("ENV: ", "connect Phase",UVM_HIGH);
        endfunction



        //run phase
        task run_phase(uvm_phase phase);
            
            super.run_phase(phase);

            `uvm_info("ENV: ", "Run Phase",UVM_HIGH);
           

        endtask //run_phass(uvn_phase phase)


endclass 
