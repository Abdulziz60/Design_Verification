
class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_analysis_imp #(i2c_sequence_item, scoreboard) analysis_export;
  bit [7:0] mem_model [bit [6:0]];
  i2c_sequence_item last_item;

  function new(string name = "scoreboard", uvm_component parent);
    super.new(name, parent);
    analysis_export = new("analysis_export", this);
    last_item = null;
  endfunction

  virtual function void write(i2c_sequence_item item);
    if (last_item != null &&
        last_item.rw       == item.rw &&
        last_item.addr     == item.addr &&
        last_item.data_in  == item.data_in &&
        last_item.data_out == item.data_out) begin
      `uvm_info(get_type_name(), ">> [SB] Skipping repeated identical transaction", UVM_LOW)
      return;
    end

    if (item.rw == 0) begin
    if (item.addr == 7'h55) begin // العنوان الصحيح فقط
      mem_model[item.addr] = item.data_in;
      `uvm_info("SB", $sformatf("[CORRECT] WRITE: mem[0x%0h] = 0x%0h", item.addr, item.data_in), UVM_LOW)
    end else begin
      `uvm_info("SB", $sformatf("[SKIPPED] WRITE: addr=0x%0h was ignored. Not updating memory.", item.addr), UVM_LOW)
    end
  end else begin
    bit [7:0] expected = mem_model[item.addr];
    if (item.addr != 7'h55) begin
      `uvm_info("SB", $sformatf("[SKIPPED] READ: addr=0x%0h is not the slave. Ignored check.", item.addr), UVM_LOW)
    end else if (item.data_out !== expected) begin
      `uvm_error("SB", $sformatf("MISMATCH ❌ : Read mem[0x%0h] = 0x%0h, expected = 0x%0h",
                                 item.addr, item.data_out, expected))
    end else begin
      `uvm_info("SB", $sformatf("READ OK ✅ : mem[0x%0h] = 0x%0h", item.addr, item.data_out), UVM_LOW)
    end
  end

  last_item = i2c_sequence_item::type_id::create("last_item_copy");
  last_item.copy(item);
endfunction
endclass




























// class scoreboard extends uvm_scoreboard;
//   `uvm_component_utils(scoreboard)

//   uvm_analysis_imp #(i2c_sequence_item, scoreboard) analysis_export;

//   // memory model
//   bit [7:0] mem_model [bit [6:0]];

//   // keep track of last transaction
//   i2c_sequence_item last_item;

//   function new(string name = "scoreboard", uvm_component parent);
//     super.new(name, parent);
//     analysis_export = new("analysis_export", this);
//     last_item = null;
//   endfunction

//   virtual function void write(i2c_sequence_item item);
//   if (last_item != null &&
//       last_item.rw       == item.rw &&
//       last_item.addr     == item.addr &&
//       last_item.data_in  == item.data_in &&
//       last_item.data_out == item.data_out) begin
//     `uvm_info(get_type_name(), ">> [SB] Skipping repeated identical transaction", UVM_LOW)
//     return;
//   end

//   if (item.rw == 0) begin
//     mem_model[item.addr] = item.data_in;
//     `uvm_info("SB", $sformatf("WRITE: mem[0x%0h] = 0x%0h", item.addr, item.data_in), UVM_LOW)
//   end else begin
//     bit [7:0] expected = mem_model[item.addr];
//     if (item.data_out !== expected)
//       `uvm_error("SB", $sformatf("MISMATCH ❌ : Read mem[0x%0h] = 0x%0h, expected = 0x%0h",
//                                  item.addr, item.data_out, expected))
//     else
//       `uvm_info("SB", $sformatf("READ OK ✅ : mem[0x%0h] = 0x%0h", item.addr, item.data_out), UVM_LOW)
//   end

//   // Store a deep copy of the current transaction
//   last_item = i2c_sequence_item::type_id::create("last_item_copy");
//   last_item.copy(item);
// endfunction


// endclass
