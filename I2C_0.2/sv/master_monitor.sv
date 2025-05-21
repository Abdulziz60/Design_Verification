class master_monitor extends uvm_monitor;
  `uvm_component_utils(master_monitor)
  virtual i2c_if vif;
  i2c_sequence_item item;
  i2c_sequence_item last_item;
  uvm_analysis_port #(i2c_sequence_item) analysis_port;

  logic [7:0] data;
  logic [7:0] addr_byte;

  function new(string name = "master_monitor", uvm_component parent);
    super.new(name, parent);
    analysis_port = new("analysis_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "vif not received in master monitor")
  endfunction

  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    forever begin
      vif.wait_start();
      vif.recv_byte(addr_byte);

      item = i2c_sequence_item::type_id::create("item");
      item.addr = addr_byte[7:1];
      item.rw   = addr_byte[0];

      if (item.rw == 0) begin
        vif.recv_byte(data);
        item.data_in = data;
        `uvm_info("master_monitor", $sformatf("WRITE captured: addr=0x%0h, data=0x%0h", item.addr, item.data_in), UVM_LOW)
      end else begin
        vif.recv_byte(data);
        item.data_out = data;
        `uvm_info("master_monitor", $sformatf("READ captured: addr=0x%0h, data=0x%0h", item.addr, item.data_out), UVM_LOW)
      end

      analysis_port.write(item);
    end
  endtask
endclass































// // class master_monitor extends uvm_monitor;
// //     `uvm_component_utils(master_monitor)
// //     virtual i2c_if vif;
// //     i2c_sequence_item item;
// //     i2c_sequence_item last_item;
// //     uvm_analysis_port #(i2c_sequence_item) analysis_port;


// //   //--------------------------------------------------------
// //   //Constructor
// //   //--------------------------------------------------------
// //     function new(string name = "master_monitor", uvm_component parent);
// //         super.new(name, parent);
// //         `uvm_info("master_monitor CLASS", "Inside Constructor !", UVM_HIGH)
// //         analysis_port = new("analysis_port", this);
// //     endfunction

// //   //--------------------------------------------------------
// //   //Build Phase
// //   //--------------------------------------------------------
// //     function void build_phase(uvm_phase phase);
// //       super.build_phase(phase);
// //       `uvm_info("master_monitor CLASS", "Build Phase!", UVM_HIGH)
// //       if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
// //       `uvm_fatal(get_type_name(), "vif not received in master monitor")
// //     else
// //       `uvm_info(get_type_name(), "vif received in master monitor", UVM_LOW)
// //     endfunction

// //     //--------------------------------------------------------
// //     //Connect Phase
// //     //--------------------------------------------------------
// //     function void connect_phase(uvm_phase phase);
// //       super.connect_phase(phase);
// //       `uvm_info("master_monitor CLASS", "Connect Phase!", UVM_HIGH)

// //     endfunction

// //     //--------------------------------------------------------
// //     //Run Phase
// //     //--------------------------------------------------------
// //     task run_phase (uvm_phase phase);
// //       super.run_phase(phase);
// //       `uvm_info("master_monitor CLASS", "Run Phase!", UVM_HIGH)

// //       forever begin
// //         @(posedge vif.clk);
// //         #10;

// //         if (vif.rw == 1'b1) begin // READ only
// //           item = i2c_sequence_item::type_id::create("item");

// //           item.addr     = vif.address;
// //           item.rw       = vif.rw;
// //           item.data_out = vif.data;

// //           // Check if this is a new transaction (not repeated)
// //           if (last_item == null ||
// //               item.addr != last_item.addr ||
// //               item.data_out != last_item.data_out) begin
              
// //             `uvm_info("MON", $sformatf("READ captured: addr=0x%0h, data=0x%0h", item.addr, item.data_out), UVM_LOW)
// //             `uvm_info("MON", "STOP detected, sending to scoreboard", UVM_LOW)

// //             analysis_port.write(item);
// //             last_item = item; // Update last sent item
// //           end else begin
// //             `uvm_info("MON", "Repeated transaction skipped", UVM_LOW)
// //           end
// //         end
// //       end
// // endtask
// // endclass