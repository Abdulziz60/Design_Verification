class trans;
    
    randc bit [7:0] a;
    randc bit [7:0] b;
    bit [8:0] c;

    function display();
                $display("a = %d, b = %d, c = %d ", a, b, c);
    endfunction
        
   
endclass // trans