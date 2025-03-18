`timescale 1ns/1ps

class transaction;
    
    rand  bit              we;   // Write enable (0 = Read, 1 = Write)
    randc logic [3:0]      addr; // Address
    randc logic [7:0]      din;  // Data input
    logic       [7:0]      dout; // Data output


    //1. Constructor to initialize class properties**
    function new();
        this.we   = 0;  // Default to read operation
        this.addr = 0;  // Default address
        this.din  = 0;  // Default input data
        this.dout = 0;  // Default output data
    endfunction

    // 2. Display method**
    function display();
        
        $display("Enable : %d, Address : %0d, Data input : %0d, Data output : %0d",
                   we, addr, din, dout );
        
    endfunction

    // 3. Constraint to control Read/Write operations**
    constraint rw_valid {
        we dist { 0 := 50, 1 := 50 }; // Equal probability of Read (0) or Write (1)
        adder dist
    }

    // 4. Copy function**
    function transaction copy();
    transaction tr_copy = new();
    tr_copy.we = this.we;
    tr_copy.addr = this.addr;
    tr_copy.din = this.din;
    tr_copy.dout = this.dout;
    return tr_copy;
endfunction

endclass // transaction