interface i2c_if (input logic clk);

  logic scl;
  wire  sda;
  logic sda_w;
  assign sda = sda_w;

  logic [6:0] slave_addr = 7'b1010101;

  logic [7:0] memory [bit[6:0]];
  logic [6:0] address;
  logic [7:0] data;
  logic       rw;

  // ========== Master Tasks ==========

  task automatic generate_scl();
    @(negedge clk);
    repeat(20) begin
      scl = ~scl;
      #5;
    end
  endtask

  task automatic stop_scl();
    scl   <= 1;
    sda_w <= 1;
  endtask

  task automatic send_start();
    $display(">>> send_start activated");
    sda_w <= 0;
    #2;
    generate_scl();
  endtask

  task automatic send_byte(input byte data);
  $display(">>> send_byte activated");

  // إرسال البتات 8 من MSB إلى LSB
  for (int i = 7; i >= 0; i--) begin
    @(negedge clk);
    sda_w <= data[i];
    @(posedge clk);
    scl <= 1;
    @(posedge clk);
    scl <= 0;
  end

  // البت التاسع: انتظار ACK من السليف
  @(negedge clk);
  sda_w <= 'z;  // حرر SDA
  @(posedge clk);
  $display("[DRV] Sent byte: 0x%0h | ACK = %b", data, sda);
  scl <= 0;
endtask


    

  task automatic send_stop();
    $display(">>> send_stop activated");
    sda_w <= 0;
    scl   <= 1;
    @(posedge clk);
    sda_w <= 1;
  endtask

  // ========== Slave Tasks ==========

  task automatic wait_start();
    wait (scl == 1 && sda == 1);
    wait (scl == 1 && sda == 0);
  endtask

  task automatic wait_stop(); endtask

  task automatic recv_byte(output logic [7:0] data);
    data = 0;
    for (int i = 7; i >= 0; i--) begin
      @(posedge scl);
      data[i] = sda;
    end
  endtask

  task automatic send_ack();
    @(negedge scl); sda_w <= 0;
    @(negedge scl); sda_w <= 'z;
  endtask

  task automatic send_nack();
    sda_w <= 1;
    @(posedge clk); scl <= 1;
    @(posedge clk); scl <= 0;
    sda_w <= 'z;
  endtask

  task automatic slave_respond_byte(input logic [7:0] data_byte);
    for (int i = 7; i >= 0; i--) begin
      @(negedge clk); sda_w <= data_byte[i];
      @(posedge clk); scl <= 1;
      @(posedge clk); scl <= 0;
    end
    @(negedge clk); sda_w <= 'z;
  endtask

  task automatic wait_nack(); endtask

endinterface
