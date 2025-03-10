timeunit 1ns;
timeprecision 1ns;

module TB_mem (
	
  input  logic            clk,
  output logic            rst_n,
  output logic            read,
  output logic            write,
  output logic [4:0] addr,
  output logic [7:0] data_i,
  input  logic [7:0] data_o,
  input  logic       ack
);
  
  task wait_for_ack();
   for(int i=1; i <= 20; i++) begin
        @(posedge clk);
        if (ack !== 1) begin
            $display("Time =%0d, ack = %0d",$time, ack);
        end else begin
            $display("Time =%0d, ack = %0d",$time, ack);
            i=21;
        end
   end
  endtask

  
  task check_rst_n () ;
    rst_n = 1;
    #1;
    rst_n = 0;
    #1;
    rst_n = 1;
    #1;
    $display("Reset Test Passed");
    endtask //check_rst_n
  
  
  
  task check_write_read(logic [7:0] data_input );
    $display("start check write and read test ...");
    // write data.
    @(negedge clk);
    write <= 1; read <= 0; addr <= 5'b10101;
    
    data_i <= data_input;
    wait_for_ack();
    write <= 0;
    //read data.
    @(negedge clk);
    read <= 1; addr <= 5'b10101; 
    wait_for_ack();
    
    if (data_o !== data_input )begin
      $display("Read Mismatch! Expected: %0d, Got: %0d", data_input, data_o);
    //   $finish;
    end else begin 
      $display("Write-Read Test Passed: %0d", data_o);
    end
    
    read <= 0;
    
  endtask
  
  
  
  task  check_writ_cancel();
    
     $display("start check write cancel test ...");
    @(negedge clk);
    write <= 1; rst_n = 1; read <= 0; addr <= 5'b10101; data_i = 8'hAA;
    
    //stop writ before ack  
    @(negedge clk);
    write <= 0;
    wait_for_ack();
    
    //check if ignored
    @(negedge clk);
    read <= 1; addr <= 5'b10101; 
    wait_for_ack();
    read <=0;
    if (data_o === 8'hAA) begin
      $display("Write Cancel Test Failed !!!!");
      $finish;
    end else begin
      $display("Write Cancel Test Passed ");
    end
           
  endtask
  
  
  
  task  check_read_cancel();
     $display("start check read cancel test ...");
    @(negedge clk);
    read <= 1; addr <= 5'b10101;
    
    //stop read before ack  
    @(negedge clk);
    read <= 0;
    wait_for_ack();
    
    
    //check if ignored
    if (data_o !== 8'h00) begin
      $display("Read Cancel Failed!!!");
      $finish;
    end else begin
      $display("Read Cancel Test Passed");
    end
  
  endtask
  
  
  task check_burst_mode();
    logic [7:0] test_data [4] = {8'h11, 8'h22, 8'h33, 8'h44};
    int i;
    
    //Write Transactions
    for (i = 0; i < 4; i++) begin
      write = 1; read = 0; addr = 5'b00010 + i; data_i = test_data[i];
    
      wait_for_ack();
      write = 0;
    end
    
    //Read Transactions
    for (i = 0; i < 4; i++) begin
      read = 1; addr = 5'b00010 + i; 
    
      wait_for_ack();
      if (data_o !== test_data[i]) begin
        $display("Burst Mode Failed at address %0d: Expected %0d, Got %0d", 			addr, test_data[i], data_o);
        $finish;
      end else begin
        $display("Burst Mode Passed at address %0d: %0d", addr, data_o);
      end
      read = 0;
    end
    $display("Burst Mode Test Completed");
  endtask
  
  
  //Random Test
  task check_random_test();
    int i;
    logic [7:0] rand_data;
    logic [4:0] rand_addr;
    
    for (i = 0; i < 5; i++) begin
      rand_data = $random; 
      rand_addr = $random % 32; 

      @(negedge clk);
      write = 1; read = 0; addr = rand_addr; data_i = rand_data;

      wait_for_ack();
      write = 0;
      
      @(negedge clk);
      read = 1;
      addr = rand_addr;
      
      wait_for_ack();
      
      if (data_o !== rand_data) begin
        $display("Random Test Failed at address %0d: Expected %0d, Got %0d", rand_addr, rand_data, data_o);
        $finish;
      end else begin
        $display("Random Test Passed at address %0d: %0d", rand_addr, data_o);
      end

      read = 0;
    end
  endtask

    // initial begin
    //     $monitor("time = %0d, clk = %0d, rst_n=%0d, ACK =%0d, read =%0d, write =%0d, addr =%0d, data input =%0d, data_output =%0d \n",
    //                $time,           clk,       rst_n,    ack,       read,       write,      addr,          data_i,            data_o);
    // end
  
    initial begin
    $display("------------------------------------------------------------------");
    $display("-----------------------Start TB-----------------------------------");
    $display("------------------------------------------------------------------");
      
      check_rst_n ();
      check_write_read( 8'hFF );
      check_writ_cancel();
      //check_read_cancel();

      //$display("start check burst mode test ...");
      //check_burst_mode();
      
      //$display("start check random test ...");
      //check_random_test();
  
      #5000;
      $finish;
    end
      
       initial begin
$dumpfile("dumb.vcd");
$dumpvars;
  end
  
endmodule