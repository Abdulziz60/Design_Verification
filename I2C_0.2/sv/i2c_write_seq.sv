class i2c_test_read_write extends uvm_sequence #(i2c_sequence_item);
  `uvm_object_utils(i2c_test_read_write)

  function new(string name = "i2c_test_read_write");
    super.new(name);
  endfunction

  task body();
    i2c_sequence_item wr, rd;

    // ============================================================
    // 1. WRITE transaction to wrong address (should be ignored)
    // ============================================================
    wr = i2c_sequence_item::type_id::create("wr_tx_wrong");
    start_item(wr);
    wr.addr     = 7'h12;           // ❌ Wrong address
    wr.rw       = 1'b0;
    wr.data_in  = 8'hA5;
    finish_item(wr);
    `uvm_info(get_type_name(), $sformatf("[WRONG] WRITE: addr=0x%0h, data=0x%0h", wr.addr, wr.data_in), UVM_LOW)

    // ============================================================
    // 2. READ transaction from wrong address (should be ignored)
    // ============================================================
    rd = i2c_sequence_item::type_id::create("rd_tx_wrong");
    start_item(rd);
    rd.addr     = 7'h12;
    rd.rw       = 1'b1;
    finish_item(rd);
    `uvm_info(get_type_name(), $sformatf("[WRONG] READ: addr=0x%0h, data_out=0x%0h", rd.addr, rd.data_out), UVM_LOW)

    // Check skipped
    `uvm_info(get_type_name(), $sformatf("[SKIPPED] CHECK: addr=0x%0h is not a valid slave address", wr.addr), UVM_LOW)


    // ============================================================
    // 3. WRITE transaction to correct slave address
    // ============================================================
    wr = i2c_sequence_item::type_id::create("wr_tx_ok");
    start_item(wr);
    wr.addr     = 7'h55;           // ✅ Correct address
    wr.rw       = 1'b0;
    wr.data_in  = 8'h5A;
    finish_item(wr);
    `uvm_info(get_type_name(), $sformatf("[CORRECT] WRITE: addr=0x%0h, data=0x%0h", wr.addr, wr.data_in), UVM_LOW)

    // ============================================================
    // 4. READ transaction from correct slave address
    // ============================================================
    rd = i2c_sequence_item::type_id::create("rd_tx_ok");
    start_item(rd);
    rd.addr     = 7'h55;
    rd.rw       = 1'b1;
    finish_item(rd);
    `uvm_info(get_type_name(), $sformatf("[CORRECT] READ: addr=0x%0h, data_out=0x%0h", rd.addr, rd.data_out), UVM_LOW)

    // ============================================================
    // 5. CHECK value from correct transaction
    // ============================================================
    if (rd.addr == 7'h55) begin
      if (rd.data_out !== wr.data_in)
        `uvm_error(get_type_name(), $sformatf("[CORRECT] MISMATCH: Expected 0x%0h, got 0x%0h", wr.data_in, rd.data_out))
      else
        `uvm_info(get_type_name(), "[CORRECT] READ matches written value ✔", UVM_LOW)
    end else begin
      `uvm_info(get_type_name(), $sformatf("[SKIPPED] CHECK: addr=0x%0h is not a valid slave address", rd.addr), UVM_LOW)
    end

  endtask
endclass
