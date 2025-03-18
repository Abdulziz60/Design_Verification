class generator;
  
  randc bit [3:0] a, b; //rand or randc 
  bit [3:0] y;

// this for what i need to use 
/*
  constraint data {a inside {[0:8], [10:11], 15}; //0 1 2 3 4 5 6 7 8 10 11 15 
                   b inside {[3:11]}; // 3 4 5 6 7 8 9 10 11
                  }
*/

//this what I need to skip

    constraint data {
        !(a inside {[3:7]}); // can not use any value in this rang { 3 : 7 }.
        !(b inside {[1:4]});
    }
  
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