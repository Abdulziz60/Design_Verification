timeunit 1ns;
timeprecision 1ns;


`include "../Task1/and_ff.sv"
`include "../Task1/TB.sv"

module top;
    logic clk;
    

// Clock Generation
initial clk = 0;
always #5 clk = ~clk;

and_ff DUT_and_ff(
    .clk(clk), 
    .rst_n(rst_n), 
    .enable(enable), 
    .a(a), 
    .b(b), 
    .z(z)
);


and_ff_test DUT_and_ff_test(

    .clk(clk), 
    .rst_n(rst_n), 
    .enable(enable), 
    .a(a), 
    .b(b), 
    .z(z)
);

initial begin
#5000;
$display("Done whit test, out of the time!!!");
$finish;
end

endmodule