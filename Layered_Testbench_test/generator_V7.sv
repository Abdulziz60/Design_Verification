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
    
    g.min = 3;
    g.max = 8;

    for(i = 0; i<10;i++)begin
      g.randomize();
      #10;
    end
    
  end
  
  
endmodule
