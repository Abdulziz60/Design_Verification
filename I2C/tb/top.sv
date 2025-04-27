module tb_top;

  logic clk;
  logic rst_n;

  wb_if wbif(clk);

  i2c_dut_dummy dut (
    .clk   (clk),
    .rst_n (rst_n),
    .cyc   (wbif.cyc),
    .stb   (wbif.stb),
    .we    (wbif.we),
    .addr  (wbif.addr[2:0]), 
    .dat_i (wbif.wdata),
    .dat_o (wbif.rdata),
    .ack   (wbif.ack),
    .sda_i (1'b1),      
    .sda_o (),
    .scl_o (),
    .sda_o_en ()
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Reset generation
  initial begin
    rst_n = 0;
    #20;
    rst_n = 1;
  end

  initial begin
    uvm_config_db#(virtual wb_if)::set(null, "uvm_test_top.env.master_agent.driver", "vif", wbif);
    uvm_config_db#(virtual wb_if)::set(null, "uvm_test_top.env.master_agent.monitor", "vif", wbif);

    run_test("i2c_test");
  end

endmodule


// `endif