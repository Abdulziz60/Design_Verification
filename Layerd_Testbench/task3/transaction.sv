class transaction ;
    randc bit [7:0] a,b;

    logic [8:0] c;

    function void display();

        $display("a = %d, b = %d , c = %d", a, b, c);
        
    endfunction

endclass