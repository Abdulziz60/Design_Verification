module top(
    input logic clk,
    input logic rst_n);

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

endmodule