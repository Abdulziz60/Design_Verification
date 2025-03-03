class sequence_item extends uvm_sequence_item;
    `uvm_object_utils(sequence_item)
    
    randc bit [7:0] a,b;
    logic [7:0] sum;
    logic carry;

    constraint c1 { a inside {[4:10]};}
    constraint c2 {b >= 200; b<= 255;}

endclass //sequence_item extends uv
