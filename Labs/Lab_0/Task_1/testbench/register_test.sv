`define PERIOD 10 
module register_test;
// local signals of the testbench
logic [7:0] out ;
logic [7:0] data ;
logic enable ;
logic rst_ = 1'b1;
logic clk = 1'b1;
// DUT instantiation
register r1 (.enable(enable), .clk(clk), .out(out), .data(data), .rst_(rst_));
// clock generation
always #5 clk = ~clk;
// generate stimulus
initial
begin
@(negedge clk)
{ rst_, enable, data } = 10'b1_X_XXXXXXXX; @(negedge clk) expect_test ( 8'hXX );
{ rst_, enable, data } = 10'b0_X_XXXXXXXX; @(negedge clk) expect_test ( 8'h00 );
{ rst_, enable, data } = 10'b1_0_XXXXXXXX; @(negedge clk) expect_test ( 8'h00 );
{ rst_, enable, data } = 10'b1_1_10101010; @(negedge clk) expect_test ( 8'hAA );
{ rst_, enable, data } = 10'b1_0_01010101; @(negedge clk) expect_test ( 8'hAA );
{ rst_, enable, data } = 10'b0_X_XXXXXXXX; @(negedge clk) expect_test ( 8'h00 );
{ rst_, enable, data } = 10'b1_0_XXXXXXXX; @(negedge clk) expect_test ( 8'h00 );
{ rst_, enable, data } = 10'b1_1_01010101; @(negedge clk) expect_test ( 8'h55 );
{ rst_, enable, data } = 10'b1_0_10101010; @(negedge clk) expect_test ( 8'h55 );
$display ( "REGISTER TEST PASSED" );
$finish; // finish the simulation at the end
end
// Separate initial block to Monitor Results and finish the simulation after certain
// time has passed, as sometimes the simulation may get stuck.
initial
begin
$timeformat ( -9, 1, " ns", 9 );
$monitor ( "time=%t enable=%b rst_=%b data=%h out=%h",
$time, enable, rst_, data, out );
#(`PERIOD * 99)
$display ( "REGISTER TEST TIMEOUT" );
$finish;
end
// SystemVerilog Task to Verify Results
task expect_test (input [7:0] expects) ;
// task can access all the signals of the testbench, e.g out is accessible directly
// no need to make out also as the input
if ( out !== expects )
begin
$display ( "out=%b, should be %b", out, expects );
$display ( "REGISTER TEST FAILED" );
$finish;
end
endtask
endmodule