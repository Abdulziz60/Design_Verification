`timescale 1ns / 1ps

// Include all necessary files
`include "/home/Abdulaziz_Salem/CX-301-DesignVerification/Labs/Lab3b/Task1/counter.sv"
`include "/home/Abdulaziz_Salem/CX-301-DesignVerification/Labs/Lab3b/Task1/upcounter.sv"
`include "/home/Abdulaziz_Salem/CX-301-DesignVerification/Labs/Lab3b/Task1/downcounter.sv"
`include "/home/Abdulaziz_Salem/CX-301-DesignVerification/Labs/Lab3b/Task1/simple_class.sv"
`include "/home/Abdulaziz_Salem/CX-301-DesignVerification/Labs/Lab3b/Task1/constructor.sv"
`include "/home/Abdulaziz_Salem/CX-301-DesignVerification/Labs/Lab3b/Task1/derived_class.sv"
`include "/home/Abdulaziz_Salem/CX-301-DesignVerification/Labs/Lab3b/Task1/counter_limits.sv"
`include "/home/Abdulaziz_Salem/CX-301-DesignVerification/Labs/Lab3b/Task1/roll_over_under.sv"
`include "/home/Abdulaziz_Salem/CX-301-DesignVerification/Labs/Lab3b/Task1/static_members.sv"
`include "/home/Abdulaziz_Salem/CX-301-DesignVerification/Labs/Lab3b/Task1/aggregate.sv"

module test;
    
    // Declare a counter handle
    counter c;
    upcounter up;
    downcounter down;
    upcounter up2;

    initial begin
        $display("=== Polymorphism Test Start ===");

        // Step 1: Instantiate upcounter
        up = new();
        c = up;  // Assign upcounter instance to counter handle
        
        // Step 2: Call next() from counter handle
        c.next(); // Expected: "Inside upcounter class, count = 1"

        // Step 3: Instantiate downcounter
        down = new();
        c = down; // Assign downcounter instance to counter handle

        // Step 4: Call next() from counter handle
        c.next(); // Expected: "Inside downcounter class, count = -1"

        // Step 5: Use $cast to convert counter handle back to upcounter
        c = up; // Assign upcounter back
        if ($cast(up2, c)) begin
            up2.next(); // Expected: "Inside upcounter class, count = 2"
        end else begin
            $display("Casting failed!");
        end

        $display("=== Polymorphism Test End ===");
    end

endmodule
