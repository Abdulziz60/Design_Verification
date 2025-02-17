module mem_test (mem_interf.tb mif);
  timeunit 1ns;
  timeprecision 1ns;

  // Debug flag
  bit debug = 1;
  logic [7:0] rdata;  // Stores data read from memory for checking
  int error_status = 0;

  // Monitor Results
  initial begin
    $timeformat(-9, 0, " ns", 9);
    #40000ns $display("MEMORY TEST TIMEOUT");
    $finish;
  end

  initial begin: memtest

    $display("===========================================================");
    $display("                  Clearing Memory Test");
    $display("===========================================================\n");

    error_status = 0;
    for (int i = 0; i < 32; i++)
      mif.write_mem(i, 0, debug);
    
    for (int i = 0; i < 32; i++) begin
      mif.read_mem(i, rdata, debug);
      checkit(i, rdata, 8'h00);
    end
    printstatus(error_status);

    $display("===========================================================");
    $display("                    Data = Address Test");
    $display("===========================================================\n");

    error_status = 0;
    for (int i = 0; i < 32; i++)
      mif.write_mem(i, i, debug);
    
    for (int i = 0; i < 32; i++) begin
      mif.read_mem(i, rdata, debug);
      checkit(i, rdata, i);
    end
    printstatus(error_status);

    $display("===========================================================");
    $display("                    Data = Random Test");
    $display("===========================================================\n");

    error_status = 0;
    logic [7:0] rand_data;

    // Scope-Based Randomization (No Constraint)
    $display(">>> Randomizing without constraints");
    for (int i = 0; i < 32; i++) begin
      assert(randomize(rand_data));
      mif.write_mem(i, rand_data, debug);
    end

    for (int i = 0; i < 32; i++) begin
      mif.read_mem(i, rdata, debug);
      checkit(i, rdata, rand_data);
    end
    printstatus(error_status);

    // Constraint: Printable ASCII characters (8'h20 - 8'h7F)
    $display(">>> Randomizing with ASCII constraint");
    for (int i = 0; i < 32; i++) begin
      assert(randomize(rand_data) with { rand_data inside {[8'h20 : 8'h7F]}; });
      mif.write_mem(i, rand_data, debug);
    end

    for (int i = 0; i < 32; i++) begin
      mif.read_mem(i, rdata, debug);
      checkit(i, rdata, rand_data);
    end
    printstatus(error_status);

    // Constraint: A-Z or a-z characters
    $display(">>> Randomizing with alphabet constraint (A-Z, a-z)");
    for (int i = 0; i < 32; i++) begin
      assert(randomize(rand_data) with { rand_data inside {[8'h41:8'h5A], [8'h61:8'h7A]}; });
      mif.write_mem(i, rand_data, debug);
    end

    for (int i = 0; i < 32; i++) begin
      mif.read_mem(i, rdata, debug);
      checkit(i, rdata, rand_data);
    end
    printstatus(error_status);

    // Constraint: Weighted (80% Uppercase, 20% Lowercase)
    $display(">>> Randomizing with weighted constraint (80% Uppercase, 20% Lowercase)");
    for (int i = 0; i < 32; i++) begin
      assert(randomize(rand_data) with { rand_data dist { [8'h41:8'h5A] := 80, [8'h61:8'h7A] := 20 }; });
      mif.write_mem(i, rand_data, debug);
    end

    for (int i = 0; i < 32; i++) begin
      mif.read_mem(i, rdata, debug);
      checkit(i, rdata, rand_data);
    end
    printstatus(error_status);

    $finish;
  end

  function void checkit (input [4:0] address, input [7:0] actual, expected);
    if (actual !== expected) begin
      $display("[CHECKER] ERROR:  Address:%d  Data:%d  Expected:%d", address, actual, expected);
      error_status++;
      $display("[CHECKER] ERROR:  error number %d", error_status);
    end
  endfunction

  function void printstatus(input int status);
    if (status == 0) begin
      $display("\n");
      $display("                                  _\\|/_");
      $display("                                  (o o)");
      $display(" ______________________________oOO-{_}-OOo______________________________");
      $display("|                                                                       |");
      $display("|                               TEST PASSED                             |");
      $display("|_______________________________________________________________________|");
      $display("\n");
    end else begin
      $display("Test Failed with %d Errors", status);
      $display("\n");
      $display("                              _ ._  _ , _ ._");
      $display("                            (_ ' ( `  )_  .__)");
      $display("                          ( (  (    )   `)  ) _)");
      $display("                         (__ (_   (_ . _) _) ,__)");
      $display("                             `~~`\ ' . /`~~`");
      $display("                             ,::: ;   ; :::,");
      $display("                            ':::::::::::::::'");
      $display(" ________________________________/_ __ \________________________________");
      $display("|                                                                       |");
      $display("|                               TEST FAILED                             |");
      $display("|_______________________________________________________________________|");
      $display("\n");
    end
  endfunction

endmodule
