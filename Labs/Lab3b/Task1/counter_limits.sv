class counter_limits extends counter;
    int limit;

    function new(int lim);
        limit = lim;
    endfunction

    function void next();
        if (limit > 0)
            $display("Counter within limit: %0d", limit);
        else
            $display("Limit exceeded!");
    endfunction
endclass
