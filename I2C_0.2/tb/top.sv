// import uvm_pkg::*;
// `include "uvm.macros.svh"

module top; 

    logic clk;

    i2c_if vif(.clk(clk));
 
    // pullup p1(vif.sda);
    
    initial begin
        clk = 0;
        forever begin
           clk = ~clk;
           #5; 
        end
    end

    initial begin
        uvm_config_db #(virtual i2c_if)::set(null,"*","vif",vif);
    end

    initial begin
        run_test("i2c_test");
    end

    initial begin
      $dumpfile("i2c_waveform.vcd");
      $dumpvars(0, top);
    //   $dumpvars(1, top.vif);
    end
     

    initial begin
        #5000;
        $finish;
    end

endmodule