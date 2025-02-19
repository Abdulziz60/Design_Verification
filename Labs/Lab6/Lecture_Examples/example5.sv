module example5;

timeunit 1ns;
timeprecision 1ps;
  logic [1:0] a;
  logic [1:0] b;


 covergroup cg_cross_except;
  coverpoint a;
  coverpoint b;
  cross a, b {
	 ignore_bins invalid0 = binsof(a) intersect {0} && binsof(b) intersect {0};
 	 ignore_bins invalid3 = binsof(a) intersect {3} && binsof(b) intersect {3}; //  
    }
endgroup

bit clk;

always #5 clk = ~clk;

  cg_cross_except cg_inst5 = new();

  initial begin
    //the following 4 lines generate 73.81% FC
    a = 0; b=0; cg_inst5.sample();  
    a = 3; b=1; cg_inst5.sample(); 
    a = 2; b=3; cg_inst5.sample(); 
    a = 1; b=2; cg_inst5.sample(); 
    #10 $finish;

  end

endmodule
