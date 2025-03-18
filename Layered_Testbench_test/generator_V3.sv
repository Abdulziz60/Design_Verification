class generator;
  
  randc bit [3:0] a, b; //rand or randc 

  
  bit [3:0] y;

endclass

module tb;
  generator g;
  int i = 0;
  int status = 0;
  initial begin
    
    
    for(i=0;i<10;i++) begin
      g = new(); // Care while working with multiple Stimuli
      g.randomize();
      $display("Value of a :%0d and b: %0d", g.a,g.b);
      #10;
    end
    
  end
  
endmodule