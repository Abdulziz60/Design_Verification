`ifndef I2C_SEQ_SV
`define I2C_SEQ_SV

import uvm_pkg::*;
`include "uvm_macros.svh"


class i2c_seq extends uvm_sequence #(i2c_seq_item);
  `uvm_object_utils(i2c_seq)

  i2c_seq_item req;

  i2c_seq_item requests[$];
  int random_txn_count = 5; 

  function new(string name = "i2c_seq");
    super.new(name);
    `uvm_info(get_type_name(), "i2c sequence run", UVM_LOW)
  endfunction

  task body();
  `uvm_info(get_type_name(), "i2c_seq body started", UVM_LOW)

  // 1. Manual requests first
  foreach (requests[i]) begin
    `uvm_info(get_type_name(), $sformatf("Starting manual request[%0d]", i), UVM_LOW)
    start_item(requests[i]);
    finish_item(requests[i]);
    `uvm_info(get_type_name(), $sformatf("Finished manual request[%0d]", i), UVM_LOW)
  end

  // 2. Randomly generate extra transactions
  for (int i = 0; i < random_txn_count; i++) begin
    req = i2c_seq_item::type_id::create($sformatf("rand_req_%0d", i));
    start_item(req);
    if (!req.randomize()) begin
      `uvm_fatal(get_type_name(), "Random transaction randomization failed")
    end
    finish_item(req);
    requests.push_back(req); // Store for scoreboard
    `uvm_info(get_type_name(), $sformatf("Finished random request[%0d]", i), UVM_LOW)
  end
endtask

endclass


`endif