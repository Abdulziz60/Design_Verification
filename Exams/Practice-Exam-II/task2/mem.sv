module mem (
  input        clk,
  input        rst_n,
  input        read,
  input        write,
  input  logic [4:0] addr,
  input  logic [7:0] data_i,
  output logic [7:0] data_o,
  output logic       ack
);
  timeunit 1ns;
  timeprecision 1ns;
  
  logic [7:0] memory [0:31];
  
  typedef enum logic [1:0] {IDLE, WAIT, ACK} state_t;
  state_t state;
  // op: 0 -> read, 1 -> write
  logic        op;
  logic [4:0]  latched_addr;
  logic [7:0]  latched_data;
  logic [3:0]  counter;
  
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state        <= IDLE;
      counter      <= 0;
      op           <= 0;
      latched_addr <= 0;
      latched_data <= 0;
    end else begin
      case (state)
        IDLE: begin
          if ((read && !write) || (write && !read)) begin
            op           <= (read) ? 0 : 1;
            latched_addr <= addr;
            if (write)
              latched_data <= data_i;
            counter <= $urandom_range(1, 10);
            state   <= WAIT;
          end
        end
        WAIT: begin
          // If the control signals or inputs change prematurely, drop the request.
          if ((op == 0 && (!read || (addr !== latched_addr))) ||
              (op == 1 && (!write || (addr !== latched_addr) || (data_i !== latched_data)))) begin
            state <= IDLE;
          end else if (counter != 0) begin
            counter <= counter - 1;
          end else begin
            state <= ACK;
          end
        end
        ACK: begin 
            memory[latched_addr] <= latched_data;
            state <= IDLE;
        end
        default: state <= IDLE;
      endcase
    end
  end
  
  assign ack = (state == ACK);

  assign data_o = ack ? memory[latched_addr] : 8'bx;
endmodule
