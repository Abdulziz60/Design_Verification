class adder_driver extends uvm_driver #(adder_seq_item);
    `uvm_component_utils(adder_driver);
    virtual adder_if vif;

    adder_seq_item seq_item;


    function new (string name = "adder_driver", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(),"Constructor", UVM_LOW);
        // `uvm_info("DRV: ", "Constructor", UVM_LOW);
        
    endfunction


    function void build_phase(uvm_phase phase);
         super.build_phase(phase);
        `uvm_info(get_type_name(),"Build Phase", UVM_LOW);

        if(!uvm_config_db#(virtual adder_if)::get(this,"","addr_if", vif ))
            `uvm_error(get_type_name(),"could not get interface from Config DB !!!");

    endfunction

     function void connect_phase(uvm_phase phase);
         super.connect_phase(phase);
        `uvm_info(get_type_name(),"connect_phase", UVM_LOW);
    endfunction

    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        `uvm_info(get_type_name(), "Run Phase!", UVM_LOW);

        forever begin 
            
            seq_item = adder_seq_item::type_id::create("seq_item");

            seq_item_port.get_next_item(seq_item);

            @( negedge vif.clk);
              vif.a <= seq_item.a;
              vif.b <= seq_item.b;

              seq_item_port.item_done();
        end
    endtask
    
endclass //adder_driver 