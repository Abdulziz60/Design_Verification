
module mem (
  input              clk,
	input              we, 
	input  logic [4:0] addr  ,
	input  logic [7:0] din  ,
  output logic [7:0] dout
);
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;

// SYSTEMVERILOG: logic data type
logic [7:0] memory [0:31] ;
  
  always_ff @(posedge clk) begin
    if (we == 1)
// SYSTEMVERILOG: time literals
       memory[addr] <= din;
  end

// SYSTEMVERILOG: always_ff and iff event control
  always_ff @(posedge clk iff ( we == 0 ))
       dout <= memory[addr];

endmodule
