class adder_seq_item extends uvm_sequence_item;

    randc bit [7:0] a,b;
    logic [7:0] sum;
    logic Carry;

    `uvm_object_utils(adder_seq_item);
    
    constraint c_a {a >= 200 ; a<= 255;}
    constraint c_b {b inside {[1:10]};}



endclass