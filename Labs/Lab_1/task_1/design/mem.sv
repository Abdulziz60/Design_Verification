module mem (
  input              clk,
  input              read,
  input              write, 
  input  logic [4:0] addr,
  input  logic [7:0] data_in,
  output logic [7:0] data_out
);
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;

// SYSTEMVERILOG: logic data type
logic [7:0] memory [0:31];
  
always_ff @(posedge clk) begin
    if (write && !read) begin
        memory[addr] <= data_in;  // Write to memory only if write is enabled
    end
end
always_ff @(posedge clk iff ((read == '1)&&(write == '0)))
  data_out <= memory[addr];

endmodule