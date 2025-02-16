module top;
timeunit 1ns;
timeprecision 1ns;

bit clk;
wire read;
wire write;
wire [4:0] addr;
wire [7:0] data_out;
wire [7:0] data_in;

mem_test test (.*);
mem memory (.clk, .read, .write, .addr, .data_in, .data_out);

always #5 clk = ~clk;
endmodule