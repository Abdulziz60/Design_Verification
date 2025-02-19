module example4;

timeunit 1ns;
timeprecision 1ps;
  logic [1:0] a;
  logic [1:0] b;


 covergroup cg_cross;
  coverpoint a;
  coverpoint b;
  cross a, b;
endgroup

bit clk;

always #5 clk = ~clk;

  cg_cross cg_inst4 = new();

  initial begin
    //the following 4 lines generate 75% FC
    a = 0; b=0; cg_inst4.sample();  
    a = 3; b=1; cg_inst4.sample(); 
    a = 2; b=3; cg_inst4.sample(); 
    a = 1; b=2; cg_inst4.sample(); 
    #10 $finish;

  end

endmodule
