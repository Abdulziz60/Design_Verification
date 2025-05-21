class slave_monitor extends uvm_monitor;
  `uvm_component_utils(slave_monitor)
  virtual i2c_if vif;
  i2c_sequence_item item;
  logic [7:0] addr_byte;
  logic [7:0] data;

  uvm_analysis_port #(i2c_sequence_item) item_collected_port;

  function new(string name = "slave_monitor", uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "vif not received in slave monitor")
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
        `uvm_info("slave_monitor", $sformatf("WRITE captured: addr=0x%0h, data=0x%0h", item.addr, item.data_in), UVM_LOW)
      end else begin
        vif.recv_byte(data);
        item.data_out = data;
        `uvm_info("slave_monitor", $sformatf("READ captured: addr=0x%0h, data=0x%0h", item.addr, item.data_out), UVM_LOW)
      end

      item_collected_port.write(item);
    end
  endtask
endclass








// class slave_monitor extends uvm_monitor;
//     `uvm_component_utils(slave_monitor)
//     virtual i2c_if vif;
//     i2c_sequence_item item;
//     logic [7:0] addr_byte;

//     uvm_analysis_port #(i2c_sequence_item) item_collected_port;

//   //--------------------------------------------------------
//   //Constructor
//   //--------------------------------------------------------
//     function new(string name = "slave_monitor", uvm_component parent);
//         super.new(name, parent);
//         `uvm_info("slave_monitor CLASS", "Inside Constructor !", UVM_HIGH)
//         item_collected_port = new("item_collected_port", this);
//     endfunction

//   //--------------------------------------------------------
//   //Build Phase
//   //--------------------------------------------------------
//     function void build_phase(uvm_phase phase);
//       super.build_phase(phase);
//       `uvm_info("slave_monitor CLASS", "Build Phase!", UVM_HIGH)

//       if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
//         `uvm_fatal(get_type_name(), "vif not received in slave monitor")
//       else
//         `uvm_info(get_type_name(), "vif received in slave monitor", UVM_LOW)
//     endfunction

//     //--------------------------------------------------------
//     //Connect Phase
//     //--------------------------------------------------------
//     function void connect_phase(uvm_phase phase);
//       super.connect_phase(phase);
//       `uvm_info("slave_monitor CLASS", "Connect Phase!", UVM_HIGH)

//     endfunction

//     //--------------------------------------------------------
//     //Run Phase
//     //--------------------------------------------------------
//     task run_phase (uvm_phase phase);
//       super.run_phase(phase);
//       `uvm_info("slave_monitor CLASS", "Run Phase!", UVM_HIGH)

//       forever begin
//         vif.wait_start();

        
//         vif.recv_byte(addr_byte);
//         `uvm_info(get_type_name(), $sformatf("MON: Received address byte = 0x%0h", addr_byte), UVM_MEDIUM)

//         item = i2c_sequence_item::type_id::create("item");
//         item.addr = addr_byte[7:1];
//         item.rw      = addr_byte[0];
//         item_collected_port.write(item);
//       end
//     endtask
// endclass