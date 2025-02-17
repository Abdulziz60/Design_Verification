class counter_with_constructor;
    int count;

    function new(int initial_value);
        count = initial_value;
        $display("Counter initialized with value: %0d", count);
    endfunction

    function void increment();
        count++;
        $display("Count incremented to: %0d", count);
    endfunction
endclass
