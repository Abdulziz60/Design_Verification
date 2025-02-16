// derived_class.sv
class counter;
    int count;

    // Constructor to initialize the count
    function new(int value = 0);
        count = value;
    endfunction
endclass : counter

// Upcounter inherits from counter
class upcounter extends counter;
    // Constructor to pass value to the parent class constructor
    function new(int value = 0);
        super.new(value);  // Call parent class constructor
    endfunction

    // Increment the count
    function void next();
        count++;
        $display("Up Counter: %0d", count);
    endfunction
endclass : upcounter

// Downcounter inherits from counter
class downcounter extends counter;
    // Constructor to pass value to the parent class constructor
    function new(int value = 0);
        super.new(value);  // Call parent class constructor
    endfunction

    // Decrement the count
    function void next();
        count--;
        $display("Down Counter: %0d", count);
    endfunction
endclass : downcounter

// Testbench
module derived_class_tb;
    initial begin
        upcounter uc = new(5);   // Initialize with 5
        downcounter dc = new(10); // Initialize with 10
        uc.next();               // Should increment to 6
        dc.next();               // Should decrement to 9
    end
endmodule
