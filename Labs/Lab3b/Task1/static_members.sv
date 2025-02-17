class static_counter;
    static int instance_count;

    function new();
        instance_count++;
        $display("New instance created. Total instances: %0d", instance_count);
    endfunction
endclass
