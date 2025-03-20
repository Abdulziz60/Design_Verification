class adder_seqr extends uvm_sequencer#(adder_seq_item);
    `uvm_component_utils(adder_seqr);

    function new (string name = "adder_seqr", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(),"Constructor", UVM_LOW);  
    endfunction


endclass