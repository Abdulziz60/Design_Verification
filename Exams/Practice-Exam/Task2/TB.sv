timeunit 1ns;
timeprecision 1ns;

module TB_updown_counter (

    input  logic clk, // synchronous to posedge
    output logic rst_n, // active low reset 
    output logic en, //counting enable
    output logic m, // counting mode 
    output logic load , // load data in
    output logic [7:0] data_in, // the data to be loaded 
    input  logic [7:0] count // count value 

);

task check_output(logic [7:0] expected);
    if ( count !== expected )begin
        $display("TEST FAILED: \n time = %0d, clk = %0d, rst_n=%d, enable = %d, counting mode = %d, load =%d,  data_in =%d, count value =%0d , expected=%d",
                 $time, clk, rst_n, en, m, load, data_in, count, expected );
        $finish;

    end
endtask 

initial begin
    rst_n = 1;
    #1;
    rst_n = 0;
    #2;
    rst_n = 1;
    #1;
    rst_n = 0;

end

initial begin

    rst_n = 1; en = 0; m = 0; load = 0 ; data_in = 0;

    //chech load signal if it is high.
    @(negedge clk); 
    rst_n = 1; en = 0; m = 0; load = 1 ; data_in = 5; 
    @(negedge clk); check_output(5);

    //load signal is low, enable signal (en) is high. 
    // counter increments (m) mode bit is low .
    //@(negedge clk); 
    rst_n = 1; en = 1; m = 0 ; load = 0 ; //data_in = 5; 
    @(negedge clk); check_output(6);

    //load signal is low, enable signal (en) is high. 
    // counter decrements (m) mode bit is high .
    //@(negedge clk); 
    rst_n = 1; en = 1; m = 1; load = 0 ; //data_in = 5;
    @(negedge clk); check_output(5);

    //Active low rst_n signals will reset the count value asynchronously
    //@(negedge clk); 
    rst_n = 0; en = 1; m = 1; load = 1; data_in = 5 ;
    @(negedge clk); check_output(0);

    //@(negedge clk); 
    rst_n = 1; en = 0; m = 0; load = 1; data_in = $random %256 ;
    @(negedge clk); check_output(data_in);

    // //
    // @(negedge clk); 
    // rst_n = 1; en = 0; m = 1; load = 0; data_in = 5;
    // @(negedge clk); check_output();

    // //
    // @(negedge clk); 
    // rst_n = 1; en = ; m = ; load = ; data_in = ;
    // @(negedge clk); check_output();

    $display("TEST PASSED ");
    $finish;

end

initial begin
  $monitor("time = %0d, clk = %0d, rst_n=%d, enable = %d, counting mode = %d, load =%d,  data_in =%d, count value =%0d ",
            $time, clk, rst_n, en, m, load, data_in, count, );  
end


endmodule