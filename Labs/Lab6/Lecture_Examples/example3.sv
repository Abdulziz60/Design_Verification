module example3;

timeunit 1ns;
timeprecision 1ps;
  logic [2:0] a;

 covergroup cg_trans;
  coverpoint a {
    bins rise = (0 => 3);  // 0→3 transition
    bins fall = (3 => 4);  // 3→4 transition
  }
endgroup

bit clk;

always #5 clk = ~clk;

  cg_trans cg_inst3 = new();

  initial begin
    a = 0; cg_inst3.sample();  
    a = 3; cg_inst3.sample(); 
    a = 4; cg_inst3.sample(); 
    //again the coverage is 100% because both bins got hit
    #10 $finish;

  end

endmodule
