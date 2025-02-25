`timescale 1ns / 1ps

module bit_serial_adder (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        load,
    input  wire        start,
    input  wire [3:0]  A,
    input  wire [3:0]  B,
    output reg  [3:0]  sum,
    output reg         done
);

  reg [3:0] A_reg, B_reg;
  reg [3:0] sum_reg;
  reg       carry;
  reg [2:0] bit_count;

  localparam IDLE   = 2'b00,
             ADDING = 2'b01,
             DONE   = 2'b10;

  reg [1:0] state;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      A_reg     <= 4'd0;
      B_reg     <= 4'd0;
      sum_reg   <= 4'd0;
      sum       <= 4'd0;
      carry     <= 1'b0;
      bit_count <= 3'd0;
      done      <= 1'b0;
      state     <= IDLE;
    end 
    else begin
      case (state)
        IDLE: begin
          done <= 1'b0;
          if (load) begin
            A_reg     <= A;
            B_reg     <= B;
            sum_reg   <= 4'd0;
            carry     <= 1'b0;
            bit_count <= 3'd0;
          end
          if (start) begin
            state <= ADDING;
          end
        end

        ADDING: begin
          wire sum_bit   = A_reg[0] ^ B_reg[0] ^ carry;
          wire carry_out = (A_reg[0] & B_reg[0]) | (carry & (A_reg[0] ^ B_reg[0]));
          sum_reg        <= {sum_bit, sum_reg[3:1]};
          A_reg          <= A_reg >> 1;
          B_reg          <= B_reg >> 1;
          carry          <= carry_out;
          bit_count      <= bit_count + 1'b1;
          if (bit_count == 3'd3) begin
            state <= DONE;
          end
        end

        DONE: begin
          sum  <= sum_reg;
          done <= 1'b1;
          state <= IDLE;
        end
      endcase
    end
  end

endmodule
