class simple_class;
    int value;
    
    function new(int val);
        value = val;
    endfunction

    function void display();
        $display("Value: %0d", value);
    endfunction
endclass
