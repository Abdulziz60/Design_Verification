module example1;
timeunit 1ns;
timeprecision 1ps;

  logic [2:0] a;
  covergroup cg;
    option.at_least = 2;
    coverpoint a;  // Tracks all 8 possible values (0-7)
    option.auto_bin_max = 2;
  endgroup
bit clk;
always #5 clk = ~clk;

  cg cg_inst = new();

  initial begin
    a = 3; cg_inst.sample();  // Bin for 3 is covered
    a = 3; cg_inst.sample();  // Bin for 5 is covered
    //together the above yield 25% coverage
    a = 0; cg_inst.sample();
    a = 1; cg_inst.sample();
    //together the above yield 50% coverage
    #10 $finish;
  end
endmodule
