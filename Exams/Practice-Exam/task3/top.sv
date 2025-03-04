timeunit 1ns;
timeprecision 1ns;

`include "../task3/bit_serial_adder.sv"
`include "../task3/TB.sv"

module top;

    logic      clk;
    logic      rst_n;
    logic      load;
    logic      start;
    logic [3:0]A;
    logic [3:0]B;
    logic [3:0]sum;
    logic      done;


// Clock Generation
initial clk = 0;
always #5 clk = ~clk;

bit_serial_adder DUT_bit_serial_adder(
    .clk(clk),
    .rst_n(rst_n),
    .load(load),
    .start(start),
    .A(A),
    .B(B),
    .sum(sum),
    .done(done)
);

TB_bit_serial_adder DUT_TB_bit_serial_adder(
    .clk(clk),
    .rst_n(rst_n),
    .load(load),
    .start(start),
    .A(A),
    .B(B),
    .sum(sum),
    .done(done)
);

initial begin
#5000;
$display("Done whit test, out of the time!!!");
$finish;
end

endmodule