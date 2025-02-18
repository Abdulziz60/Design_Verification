// Transaction class representing input and output data for DUT
class trans;
    
    // Random cyclic 8-bit variables for inputs a and b
    randc bit [3:0] a;  
    randc bit [3:0] b;  

    // 9-bit variable for output (to accommodate overflow cases)
    bit [4:0] c;  

    // Function to display transaction details
    function display();
        $display("a = %d, b = %d, c = %d ", a, b, c);
    endfunction
  
  	function trans copy();

        copy = new();
        copy.a = this.a;
        copy.b = this.b;
        copy.c = this.c;
        
    endfunction 
  
        
endclass // trans
