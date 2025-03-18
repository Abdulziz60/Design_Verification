//pre-randomize
//post-randomize
class generator;
  
  randc bit [3:0] a,b; 
  bit [3:0] y;
  
  int min;
  int max;
  
  function void pre_randomize();
    $display("Pre-Randomize: Setting Range [%0d:%0d]", min, max);
  endfunction
  
  constraint data {
    a inside {[min:max]};
    b inside {[min:max]};
  }
  
  function void post_randomize();
    $display("Randomized: a = %0d, b = %0d (Range: [%0d:%0d])", a, b, min, max);
  endfunction 
endclass

module tb;
  
  int i =0;
  generator g;
  
  initial begin
    g = new();
    
    $display("SPACE 1");
    // g.pre_randomize(3,12);
    g.max = 12;
    g.min = 3;

    for(i = 0; i<6;i++)begin
      g.randomize();
      #10;
    end
    $display("SPACE 2");
    // g.pre_randomize(3,12);//3 4 5 6 7 8 9 10 11 12
     g.max = 12;
     g.min = 3;
     for(i = 0; i<6;i++)begin
      g.randomize();
      #10;
    end
    
  end
  
endmodule