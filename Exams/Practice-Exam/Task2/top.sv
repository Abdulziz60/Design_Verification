timeunit 1ns;
timeprecision 1ns;

`include "../Task2/updown-counter.sv"
`include "../Task2/TB.sv"

module top;

    logic clk;
    logic rst_n; 
    logic en; 
    logic m;
    logic load; 
    logic [7:0] data_in; 
    logic [7:0] count; 


// Clock Generation
initial clk = 0;
always #5 clk = ~clk;


updown_counter DUT_updown_counter(
    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .m(m),
    .load(load),
    .data_in(data_in),
    .count(count)
);


TB_updown_counter DUT_TB_updown_counter(

    .clk(clk),
    .rst_n(rst_n),
    .en(en),
    .m(m),
    .load(load),
    .data_in(data_in),
    .count(count)
);

initial begin
    #5000;
    $display("Done whit test, out of the time!!!");
    $finish;
end

endmodule