module example6;

timeunit 1ns;
timeprecision 1ps;
  logic [1:0] a;
  logic valid;

covergroup cg_cond;
  // Cover 'a' only when 'valid' is high
  coverpoint a iff (valid);

  // Track 'valid' itself
  coverpoint valid {
    bins active = {1};
    bins idle = {0};
  }

endgroup

bit clk;

always #5 clk = ~clk;

  cg_cond cg_inst6 = new();

  initial begin
    //the following 2 lines generate % FC
    a = 0; valid =0; cg_inst6.sample();  
           valid =1; cg_inst6.sample(); 
    #10 $finish;

  end

endmodule
