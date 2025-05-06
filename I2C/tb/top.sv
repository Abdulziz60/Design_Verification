module tb_top;

  logic clk;
  logic rst_n;

  i2c_if i2c(clk);

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset generation
  initial begin
    rst_n = 0;
    repeat (2) @(posedge clk);
    rst_n = 1;
  end

  assign i2c.rst_n = rst_n;

  initial begin
    

    // Set virtual interface in Config DB before run_test
    uvm_config_db#(virtual i2c_if)::set(null, "uvm_test_top.env.master_agent", "vif", i2c);
    uvm_config_db#(virtual i2c_if)::set(null, "uvm_test_top.env.master_agent.driver", "vif", i2c);
    uvm_config_db#(virtual i2c_if)::set(null, "uvm_test_top.env.master_agent.monitor", "vif", i2c);

    uvm_config_db#(virtual i2c_if)::set(null, "uvm_test_top.env.slave_agent", "vif", i2c);
    uvm_config_db#(virtual i2c_if)::set(null, "uvm_test_top.env.slave_agent.driver", "vif", i2c);
    uvm_config_db#(virtual i2c_if)::set(null, "uvm_test_top.env.slave_agent.monitor", "vif", i2c);

    $display("==== Starting I2C UVM Simulation ====");
    run_test("i2c_test");
  end

  initial begin
    $dumpfile("i2c_waveform.vcd");
    $dumpvars(0, tb_top);
  end

  initial begin
    #5000;
    $finish;
  end

endmodule
