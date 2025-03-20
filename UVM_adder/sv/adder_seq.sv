class adder_seq extends uvm_sequence #(adder_seq_item);

    `uvm_object_utils(adder_seq);
    adder_seq_item seq_item;

    function new (string name = "adder_seq");
        super.new (name);
    endfunction

    task body();

        seq_item = adder_seq_item :: type_id::create("seq_item");

        start_item(seq_item);
        seq_item.randomize();
        finish_item(seq_item);

    endtask
endclass