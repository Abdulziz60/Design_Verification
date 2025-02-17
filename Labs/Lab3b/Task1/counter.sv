// Define a virtual base class for counter
virtual class counter;
    
    // Protected variable to store count value
    protected int count;

    // Constructor (not instantiable due to virtual class)
    function new();
        count = 0;
    endfunction

    // Virtual method to be overridden
    virtual function void next();
        $display("Inside counter class, count = %0d", count);
    endfunction

endclass
