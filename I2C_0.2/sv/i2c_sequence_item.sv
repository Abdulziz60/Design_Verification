`include "uvm_macros.svh"
import uvm_pkg::*;

class i2c_sequence_item extends uvm_sequence_item;
    

    //instantion
    rand bit [7:0] addr;
    rand bit [7:0] data_in;
    bit [7:0] data_out;


    function new(string name = "i2c_sequence_item");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(i2c_sequence_item)
        `uvm_field_int(addr,     UVM_ALL_ON)
        `uvm_field_int(data_in,  UVM_ALL_ON)
        `uvm_field_int(data_out, UVM_ALL_ON)
    `uvm_object_utils_end

endclass
