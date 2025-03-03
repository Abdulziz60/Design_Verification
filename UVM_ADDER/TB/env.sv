class my_env extends uvm_env;

        `uvm_component_utils(my_env);

        my_env env;
        my_sequence seq; 

        //Constructor.
        function new (string name = "my_env", uvm_component parent);
        super.new(name,parent);
        `uvm_info("ENV: ", "Connect Phase",UVM_HIGH);
        endfunction


        //build phase
        function void build_phase(uvm_phase Phase);
            super.build_phase(Phase);
            `uvm_info("ENV: ","Run Phase",UVM_HIGH);

            driver = my_driver::type_id::create("driver",this);
            driver = my_sequence::type_id::create("sequence",this);

        endfunction
        
        //connect phase
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            `uvm_info("ENV: ", "connect Phase",UVM_HIGH);

            driver.seq_item_port.connect(sequencer.seq_item_export);

        endfunction



        //run phase
        task run_phase(uvm_phase phase);
            
            super.run_phase(phase);
            phase.raise_objection(this)
            `uvm_info("ENV: ", "Run Phase",UVM_HIGH);
           
           seq = my_sequence :: type_id : create("seq");
           seq.start(env.sequencer);

           phase.drop_objection(this);

        endtask //run_phass(uvn_phase phase)


endclass 
