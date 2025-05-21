class slave_driver extends uvm_driver#(i2c_sequence_item);
  `uvm_component_utils(slave_driver)
  virtual i2c_if vif;

  typedef enum {IDLE, WAIT_START, ADDR_RECV, WRITE_RECV, READ_SEND, STOP} fsm_state_t;
  fsm_state_t state = IDLE;

  localparam logic [6:0] slave_addr = 7'b1010101;
  logic [7:0] addr_byte;
  logic [7:0] data_byte;
  bit rw;

  function new(string name = "slave_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "vif not received")
  endfunction

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      case (state)

        IDLE: begin
          state = WAIT_START;
        end

        WAIT_START: begin
          vif.wait_start();
          state = ADDR_RECV;
        end

        ADDR_RECV: begin
          vif.recv_byte(addr_byte);
          if (^addr_byte === 1'bx || ^addr_byte === 1'bz) begin
            `uvm_error("SLAVE_DRIVER", $sformatf("Invalid addr_byte = 0x%0h", addr_byte))
            state = STOP;
          end else begin
            rw = addr_byte[0];
            if (addr_byte[7:1] == slave_addr) begin
              vif.send_ack();
              `uvm_info("SLAVE_DRIVER", $sformatf("Accepted addr=0x%0h, rw=%0b", addr_byte[7:1], rw), UVM_MEDIUM)
              state = (rw == 0) ? WRITE_RECV : READ_SEND;
            end else begin
              `uvm_info("SLAVE_DRIVER", $sformatf("Address mismatch: got=0x%0h, expected=0x%0h. No ACK sent.", addr_byte[7:1], slave_addr), UVM_MEDIUM)
              state = STOP;
            end
          end
        end

        WRITE_RECV: begin
          @(posedge vif.scl);
          vif.recv_byte(data_byte);
          vif.send_ack();
          vif.memory[slave_addr] = data_byte;
          `uvm_info("SLAVE_DRIVER", $sformatf("Stored 0x%0h at addr 0x%0h", data_byte, slave_addr), UVM_MEDIUM)
          state = STOP;
        end

        READ_SEND: begin
          vif.send_byte(vif.memory[slave_addr]);
          vif.wait_nack();
          `uvm_info("SLAVE_DRIVER", $sformatf("Sent 0x%0h from addr 0x%0h", vif.memory[slave_addr], slave_addr), UVM_MEDIUM)
          state = STOP;
        end

        STOP: begin
          vif.wait_stop();
          state = IDLE;
        end

        default: state = IDLE;

      endcase
    end
  endtask
endclass






































// class slave_driver extends uvm_driver#(i2c_sequence_item);
//     `uvm_component_utils(slave_driver)
//     virtual i2c_if  vif;
//     logic [7:0] addr_rw;
//     logic [6:0]    addr;
//     logic           rw ;
//     logic [7:0] addr_byte;
//     logic [7:0] data_byte;
//     logic [7:0] data_out ;  

    
    
//     rand bit [6:0] configured_address = 7'h02;

//   //--------------------------------------------------------
//   //Constructor
//   //--------------------------------------------------------
//     function new(string name = "slave_driver", uvm_component parent);
//         super.new(name, parent);
//         `uvm_info("slave_driver CLASS", "Inside Constructor !", UVM_HIGH)
//     endfunction

//   //--------------------------------------------------------
//   //Build Phase
//   //--------------------------------------------------------
//     function void build_phase(uvm_phase phase);
//       super.build_phase(phase);
//       `uvm_info("slave_driver CLASS", "Build Phase!", UVM_HIGH)

//       if (!uvm_config_db#(virtual i2c_if)::get(this, "", "vif", vif))
//        `uvm_fatal(get_type_name(), "vif not received in slave driver")
//       else
//        `uvm_info(get_type_name(), "vif received in slave driver", UVM_LOW)
//     endfunction

//     //--------------------------------------------------------
//     //Connect Phase
//     //--------------------------------------------------------
//     function void connect_phase(uvm_phase phase);
//       super.connect_phase(phase);
//       `uvm_info("slave_driver CLASS", "Connect Phase!", UVM_HIGH)

//     endfunction

//     //--------------------------------------------------------
//     //Run Phase
//     //--------------------------------------------------------
//     logic [6:0] real_addr = addr_byte[7:1];
    
//     task run_phase (uvm_phase phase);
//       super.run_phase(phase);
      
//       `uvm_info("slave_driver CLASS", "Run Phase!", UVM_HIGH)

//       forever begin
//       // Phase 1: Write
//       vif.wait_start();
//       vif.recv_byte(addr_byte);   // receive address + write
//       vif.send_ack();
//       vif.recv_byte(data_byte);   // receive data
//       vif.send_ack();

//       // Store data in slave memory
//       vif.memory[addr_byte[7:1]] = data_byte; // remove RW bit
//       `uvm_info(get_type_name(), $sformatf("Stored data 0x%0h at address 0x%0h",
//                   data_byte, addr_byte[7:1]), UVM_MEDIUM)

//       // Phase 2: Read
//       vif.wait_start();
//       vif.recv_byte(addr_byte);   // receive address + read
//       vif.send_ack();

//       // Extract address without RW bit and send data
      
//       data_out = vif.memory[real_addr];
//       vif.slave_respond_byte(data_out);

//       // Wait for master's NACK
//       vif.wait_nack();
//     end
//   endtask
// endclass