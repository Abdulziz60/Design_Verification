class my_driver extends uvm_env #(sequence_item);

        `uvm_component_utils(my_driver);

        virtual vif;

        //Constructor.
        function new (string name = "my_driver", uvm_component parent);
        super.new(name,parent);
        `uvm_info("driver: ", "Connect Phase",UVM_HIGH);
        endfunction


        //build phase
        function void build_phase(uvm_phase Phase);
            super.build_phase(Phase);

            `uvm_info("driver: ","Run Phase",UVM_HIGH);
            uvm_config_db#(virtual dut_if)::get(this,"","dut_if",vif);

        endfunction
        
        //connect phase
        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            `uvm_info("driver: ", "connect Phase",UVM_HIGH);
        endfunction



        //run phase
        task run_phase(uvm_phase phase);
            
            super.run_phase(phase);

            `uvm_info("driver: ", "Run Phase",UVM_HIGH);
           
            forever begin
                item = sequence_item :: type_id :: create("item");
                seq_item_port.get_next_item(item);

                @(negedge vif.clk);
                vif.a <= item.a; 
                vif.b <= item.b;
                `uvm_info("driver :",$sformatf("a=%d, "))
                seq_item_port.item_done(); 
            end

        endtask //run_phass(uvn_phase phase)


endclass 
