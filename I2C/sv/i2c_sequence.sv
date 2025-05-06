`ifndef I2C_SEQ_SV
`define I2C_SEQ_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class i2c_seq extends uvm_sequence #(i2c_seq_item);
  `uvm_object_utils(i2c_seq)

  i2c_seq_item requests[$];
  int unsigned random_txn_count = 0;

  function new(string name = "i2c_seq");
    super.new(name);
  endfunction

  virtual task body();
    i2c_seq_item req;

    // Execute directed transactions
    foreach (requests[i]) begin
      start_item(requests[i]);
      finish_item(requests[i]);
      `uvm_info(get_type_name(),
        $sformatf(">>> DIRECTED TXN: addr=0x%0h, data=0x%0h, op=%s",
          requests[i].address, requests[i].data, requests[i].op.name()),
        UVM_MEDIUM)
    end

    // Randomized transactions
    for (int i = 0; i < random_txn_count; i++) begin
      req = i2c_seq_item::type_id::create($sformatf("rand_req_%0d", i));
      start_item(req);
      if (!req.randomize()) begin
        `uvm_error(get_type_name(), "Randomization failed for i2c_seq_item")
        continue;
      end
      `uvm_info(get_type_name(),
        $sformatf(">>> RANDOM TXN: addr=0x%0h, data=0x%0h, op=%s",
          req.address, req.data, req.op.name()),
        UVM_MEDIUM)
      finish_item(req);
      requests.push_back(req); // Optional
    end
  endtask
endclass


`endif
