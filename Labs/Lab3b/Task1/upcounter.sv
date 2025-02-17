class upcounter extends counter;
    
    // Override next function
    function void next();
        count++;
        $display("Inside upcounter class, count = %0d", count);
    endfunction

endclass
