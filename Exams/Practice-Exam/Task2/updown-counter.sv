module updown_counter (
  input             clk,
  input             rst_n,
  input             en,
  input             m,
  input             load,
  input      [7:0]  data_in,
  output reg [7:0]  count
);

always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
    count <= 8'd0;
  end else if (load) begin
    count <= data_in;
  end else if (en) begin
    if (m == 1'b0) begin
      count <= count + 1'b1;
    end else begin
      count <= count - 1'b1;
    end
  end
end

endmodule
