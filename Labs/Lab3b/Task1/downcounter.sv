class downcounter extends counter;
    
    // Override next function
    function void next();
        count--;
        $display("Inside downcounter class, count = %0d", count);
    endfunction

endclass
