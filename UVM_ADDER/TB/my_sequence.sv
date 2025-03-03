class my_sequence extends uvm_sequence #(sequence_item);
   
   `uvm_object_utils(my_sequence);
   sequence_item item;
   
    function new(string name ="my_sequence");
        super.new(name);        
    endfunction //new()

    task body();

        item = sequence_item :: type_id ::create("item");
        start_item(item);
        if(!item.randomize())
        `uvm_info("SEQ","Rando mization failed",UVM_HIGH);
        finish_item(item);
        
    endtask


endclass //my_sequence extends uvm_sequence #(sequence_item)