`timescale 1ns/1ps

module i2c_dut_dummy (
  input  logic        clk,
  input  logic        rst_n,

  // Wishbone Interface
  input  logic        cyc,
  input  logic        stb,
  input  logic        we,
  input  logic [6:0]  addr,
  input  logic [7:0]  dat_i,
  output logic [7:0]  dat_o,
  output logic        ack,

  // I2C Physical Interface
  input  logic        sda_i,
  output logic        sda_o,
  output logic        scl_o,
  output logic        sda_o_en
);

  // Internal memory model
  logic [7:0] mem [0:127];
  logic       ack_reg;

  assign dat_o = mem[addr];
  assign ack   = ack_reg;

  // Dummy I2C outputs
  assign sda_o    = 1'b1;
  assign scl_o    = 1'b1;
  assign sda_o_en = 1'b0;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      ack_reg <= 0;
    end else begin
      // default no ack
      ack_reg <= 0;

      // process only if strobe and cycle are high
      if (cyc && stb) begin
        ack_reg <= 1; // always ACK

        if (we) begin
          mem[addr] <= dat_i;
          $display("[DUT][WRITE] mem[0x%0h] <= 0x%0h", addr, dat_i);
        end else begin
          $display("[DUT][READ] mem[0x%0h] => 0x%0h", addr, mem[addr]);
        end

        $display("[DUT] ACK sent for addr=0x%0h", addr);
      end
    end
  end

endmodule
