

module TB_bit_serial_adder(

    input  logic      clk,
    output logic      rst_n,
    output logic      load,
    output logic      start,
    output logic [3:0]A,
    output logic [3:0]B,
    input  logic [3:0]sum,
    input  logic      done

);

task check_output(logic [3:0] expected_sum );
    if(sum !== expected_sum )begin
        $display("TEST FAILED :\n time = %0d, clk = %0d, rst_n = %0d, load = %0d, start = %0d, A = %0d, B = %0d, sum = %0d, done = %0d, expected_sum = %0d ",
                $time, clk, rst_n, load, start, A, B, sum, done, expected_sum);
        $finish;
    end else begin
        $display("TEST case pass :\n time = %0d, clk = %0d, rst_n = %0d, load = %0d, start = %0d, A = %0d, B = %0d, sum = %0d, done = %0d, expected_sum = %0d ",
                $time, clk, rst_n, load, start, A, B, sum, done, expected_sum);
        
    end

endtask


initial begin

  rst_n = 0;
  #1;
  rst_n = 1;
  #2;
  rst_n = 0;
  #1;
  rst_n = 0;
end


initial begin
    @(negedge clk);
    // Initialize Inputs
    rst_n = 1;
    load = 0;
    start = 0;
    A = 4'b0000;
    B = 4'b0000;

    //case 1 :-
    //load A & B.
    @(negedge clk);
                //A=13       //B=11
    load = 1; A = 4'b1101; B = 4'b1011; 
    @(negedge clk); 
    load = 0;

    //Start Add
    // @(negedge clk);
    start = 1;
    repeat (4) @(negedge clk);
    start = 0;

    //wait for done
    wait(done);

    check_output(4'b11000);

    @(negedge clk);
    $display("----------------------------time= %0d------------------------------------", $time);    
    $display("-------------------------------------------------------------------------");
    $display("----------------------------TEST PASS------------------------------------");
    $display("-------------------------------------------------------------------------");


    $finish;
end

initial begin
    $monitor("time = %0d, clk = %0d, rst_n = %0d, load = %0d, start = %0d, A = %0d, B = %0d, sum = %0d, done = %0d ",
                $time, clk, rst_n, load, start, A, B, sum, done);
end

endmodule