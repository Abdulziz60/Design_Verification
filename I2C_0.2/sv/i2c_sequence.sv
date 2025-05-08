
class i2c_sequence extends uvm_sequence;
    `uvm_object_utils(i2c_sequence)

    function new(string name = "i2c_sequence");
        super.new(name);
        `uvm_info("i2c_sequence CLASS", "Inside Constructor !", UVM_HIGH)
    endfunction

    task body();
        `uvm_info("i2c_sequence CLASS", "Inside body CLASS !", UVM_HIGH )

    endtask

endclass