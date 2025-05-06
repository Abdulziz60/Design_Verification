//============================================================
// File: i2c_read_seq.sv
// Description: Read sequence for I2C
//============================================================

`ifndef I2C_READ_SEQ_SV
`define I2C_READ_SEQ_SV

class i2c_read_seq extends uvm_sequence #(i2c_seq_item);
  `uvm_object_utils(i2c_read_seq)

  function new(string name = "i2c_read_seq");
    super.new(name);
  endfunction

  virtual task body();
    for (int i = 0; i < 10; i++) begin
      i2c_seq_item tr = i2c_seq_item::type_id::create("tr");
      start_item(tr);
      assert(tr.randomize());
      tr.op = I2C_READ;
      `uvm_info(get_type_name(), $sformatf("READ -> Addr: 0x%0h", tr.address), UVM_LOW);
      finish_item(tr);
    end
  endtask
endclass

`endif