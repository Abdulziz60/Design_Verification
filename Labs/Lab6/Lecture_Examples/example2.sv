module example2;

timeunit 1ns;
timeprecision 1ps;
  logic [2:0] a;



covergroup cg_manual;

  coverpoint a {

    bins low = {0, 1, 2};      // Values 0-2
    bins mid = {3, 4};         // Values 3-4
    bins high = {5, 6, 7};     // Values 5-7
   bins reserved = default;   // Catch-all (unused here)

  }

endgroup

bit clk;

always #5 clk = ~clk;

  cg_manual cg_inst2 = new();

  initial begin
    a = 0; cg_inst2.sample();  // Bin low is covered
    a = 3; cg_inst2.sample();  // Bin mid  is covered
    a = 5; cg_inst2.sample();  // Bin high is covered
    //even though not all values of a are covered, vcs reports 100% 
    //functional coverage as all the above values hit all the bins	
    #10 $finish;

  end

endmodule
