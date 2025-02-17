class rollover_counter extends counter;
    int count;
    int max_value;

    function new(int max);
        max_value = max;
        count = 0;
    endfunction

    function void next();
        count++;
        if (count >= max_value) begin
            count = 0; // Reset counter (rollover)
            $display("Counter rolled over");
        end else begin
            $display("Counter value: %0d", count);
        end
    endfunction
endclass
