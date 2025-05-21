// ============ master_driver.sv ============
class master_driver extends uvm_driver #(i2c_sequence_item);
  `uvm_component_utils(master_driver)
  virtual i2c_if vif;

  typedef enum {IDLE, START_COND, ADDR_SEND, WRITE_SEND, READ_RECV, NACK_SEND, STOP_COND} fsm_state_t;
  fsm_state_t state = IDLE;

  bit [7:0] addr_byte;
  i2c_sequence_item tx;

  function new(string name = "master_driver", uvm_component parent);
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
          seq_item_port.get_next_item(tx);
          addr_byte = {tx.addr, tx.rw};
          state = START_COND;
        end

        START_COND: begin
          vif.send_start();
          state = ADDR_SEND;
        end

        ADDR_SEND: begin
  vif.send_byte(addr_byte);         // Send address + R/W
  @(posedge vif.clk);               // Wait for 9th bit (ACK)
  
  if (vif.sda === 1'b1 || vif.sda === 1'bz) begin
    `uvm_warning("MASTER_DRIVER", $sformatf("No ACK received for addr=0x%0h. Aborting transaction.", addr_byte))
    vif.send_stop();
    seq_item_port.item_done();
    state = IDLE;
    disable fork;  // <<< 🔥 هذا هو المفتاح لضمان الخروج النهائي من الـ task
  end else begin
    state = (tx.rw == 0) ? WRITE_SEND : READ_RECV;
  end
end





        

        WRITE_SEND: begin
          vif.send_byte(tx.data_in);
          `uvm_info("MASTER_DRIVER", $sformatf("WRITE: addr=0x%0h data=0x%0h", tx.addr, tx.data_in), UVM_LOW)
          state = STOP_COND;
        end

        READ_RECV: begin
          vif.recv_byte(tx.data_out);
          state = NACK_SEND;
        end

        NACK_SEND: begin
          vif.send_nack();
          `uvm_info("MASTER_DRIVER", $sformatf("READ: addr=0x%0h data=0x%0h", tx.addr, tx.data_out), UVM_LOW)
          state = STOP_COND;
        end

        STOP_COND: begin
          vif.send_stop();
          seq_item_port.item_done();
          state = IDLE;
        end

        default: state = IDLE;
      endcase
    end
  endtask
endclass