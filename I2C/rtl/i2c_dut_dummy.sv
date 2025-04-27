
module i2c_dut_dummy (
  input  logic        clk,
  input  logic        rst_n,

  // Wishbone Interface
  input  logic        cyc,
  input  logic        stb,
  input  logic        we,
  input  logic [2:0]  addr,
  input  logic [7:0]  dat_i,
  output logic [7:0]  dat_o,
  output logic        ack,

  // I2C Physical Interface
  input  logic        sda_i,
  output logic        sda_o,
  output logic        scl_o,
  output logic        sda_o_en
);

  // Simple internal memory model for I2C transaction buffering
  logic [7:0] mem [0:7];
  logic [2:0] mem_ptr;

  // Simple state machine for demonstration
  typedef enum logic [1:0] {
    IDLE,
    WRITE,
    READ
  } state_t;

  state_t state, next_state;

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state <= IDLE;
      mem_ptr <= 0;
    end else begin
      state <= next_state;
    end
  end

  always_comb begin
    next_state = state;
    ack = 0;
    dat_o = 8'h00;

    case (state)
      IDLE: begin
        if (cyc && stb) begin
          if (we)
            next_state = WRITE;
          else
            next_state = READ;
        end
      end

      WRITE: begin
        if (cyc && stb && we) begin
          mem[addr] = dat_i;
          ack = 1;
          next_state = IDLE;
        end
      end

      READ: begin
        if (cyc && stb && !we) begin
          dat_o = mem[addr];
          ack = 1;
          next_state = IDLE;
        end
      end

      default: next_state = IDLE;
    endcase
  end

  // Dummy I2C signals (can be enhanced later)
  assign sda_o    = 1'b1;
  assign scl_o    = 1'b1;
  assign sda_o_en = 1'b0;

endmodule
