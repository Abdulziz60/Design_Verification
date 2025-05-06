`ifndef I2C_IF_SV
`define I2C_IF_SV

interface i2c_if(input logic clk);
  logic rst_n;
  tri sda;
  tri scl;

  logic sda_drive, scl_drive;
  logic sda_en, scl_en;

  assign sda = sda_en ? sda_drive : 1'bz;
  assign scl = scl_en ? scl_drive : 1'bz;

  logic       valid;
  logic [6:0] address;
  logic [7:0] data;
  logic       rw;

  logic [7:0] memory [bit[6:0]];
  bit [6:0] current_address;
  bit is_address_phase;

  logic scl_slave; // Slave-specific clock
  bit   slave_clk_active;

  initial begin
    scl_drive = 1; scl_en = 1;
    sda_drive = 1; sda_en = 0;
    scl_slave = 0;
    slave_clk_active = 0;
  end

  // Clock for slave (toggles when slave_clk_active = 1)
  always @(posedge clk) begin
    if (slave_clk_active)
      scl_slave <= ~scl_slave;
    else
      scl_slave <= 0;
  end

  task automatic send_start();
    @(posedge clk);
    scl_en = 1; scl_drive = 1;
    sda_en = 1; sda_drive = 1;
    @(posedge clk);
    sda_drive = 0;
    @(posedge clk);
    scl_drive = 0;

    slave_clk_active = 1; // Start slave clock

    $display("[I2C_IF] START");
  endtask

  task automatic send_stop();
    @(posedge clk);
    scl_drive = 0; scl_en = 1;
    sda_drive = 0; sda_en = 1;
    @(posedge clk);
    scl_drive = 1;
    @(posedge clk);
    sda_drive = 1;
    scl_en = 0; sda_en = 0;

    slave_clk_active = 0; // Stop slave clock

    $display("[I2C_IF] STOP");
  endtask

  task automatic send_bit(input logic bit_val);
    @(posedge clk);
    scl_drive = 0; scl_en = 1;
    sda_en = 1; sda_drive = bit_val;
    @(posedge clk);
    scl_drive = 1;
    @(posedge clk);
    scl_drive = 0;
    sda_en = 0;
  endtask

  task automatic send_byte(input logic [7:0] byte_data);
    $display("[I2C_IF] Sending byte: 0x%0h", byte_data);
    for (int i = 7; i >= 0; i--) send_bit(byte_data[i]);

    sda_en = 0; @(posedge clk);
    scl_en = 1; scl_drive = 1;
    @(posedge clk);
    if (sda !== 0) $display("[I2C_IF][ERROR] ACK not received (SDA = %b)", sda);
    else $display("[I2C_IF] ACK received (SDA = 0)");
    scl_drive = 0; scl_en = 0;

    valid <= 1; data <= byte_data;
    if (is_address_phase) begin
      current_address = byte_data[7:1];
      rw <= byte_data[0];
      address <= current_address;
      $display("[I2C_IF] Target Address = 0x%0h, RW = %0b", current_address, rw);
      is_address_phase = 0;
    end else begin
      memory[current_address] = byte_data;
      address <= current_address;
      rw <= 0;
      $display("[I2C_IF] Writing to memory[0x%0h] = 0x%0h", current_address, byte_data);
    end
    @(posedge clk); valid <= 0;
  endtask

  task automatic recv_byte(output logic [7:0] byte_out);
  byte_out = 8'h00;
  for (int i = 7; i >= 0; i--) begin
    @(posedge scl_slave);
    byte_out[i] = sda;
  end
endtask

  task automatic slave_respond_byte(input logic [7:0] byte_in);
  for (int i = 7; i >= 0; i--) begin
    @(negedge scl_slave);
    sda_en    <= 1;
    sda_drive <= byte_in[i];
  end
  @(negedge scl_slave);
  sda_en <= 0;
endtask

  task send_ack();
  @(negedge scl_slave);
  sda_en    <= 1;
  sda_drive <= 0;
  @(posedge scl_slave);
  sda_en    <= 0;
endtask


  task send_nack();
  @(negedge scl);
  sda_en    <= 1;
  sda_drive <= 1;
  @(posedge scl);
  sda_en    <= 0;
endtask



  task automatic wait_start();
    $display("[I2C_IF] Waiting for START (stub)");
  endtask

  task automatic wait_nack();
    $display("[I2C_IF] Waiting for NACK (stub)");
  endtask

  task automatic wait_stop();
    $display("[I2C_IF] Waiting for STOP (stub)");
  endtask

endinterface

`endif
