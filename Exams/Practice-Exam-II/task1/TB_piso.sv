module TB_piso(

    input  logic       clk,
    output  logic       rst_n,
    output logic       load,
    output logic [7:0] data_i,
    input  logic       serial_o
    );


    task check_rst_n () ;
        rst_n = 1;
        #1;
        rst_n = 0;
        #1;
    
        rst_n = 1;
    endtask //check_rst_n

    //load data directed 
    task check_load (logic [7:0] data);
        @(negedge clk);
        rst_n <= 1;
        
        load <= 1;
        
        data_i <= data;
        @(negedge clk);
        load <= 0;

    endtask // check_load

    //check data bit by bit at negedge for 8 clock
    task check_load_monitor (logic [7:0] data);
            for(int i=0; i < 8; i++) begin
                @(negedge clk);
                if (serial_o != data[i])begin
                    $display("fild at %0d bit ", i);  
                    $finish;

                end
            end
                $display("check load monitor is Pass");
                $display("data : %0d ", data);
                // $finish;

            
        
    endtask //check_load_monitor

    task random_data ();
        
    endtask //random_data


// always #5 clk = ~clk;
logic [7:0] random_data1 ;
initial begin
    $display("------------------------------------------------------------------");
    $display("-----------------------Start TB-----------------------------------");
    $display("------------------------------------------------------------------");

    check_rst_n();
    check_load_monitor(8'hFF);
    check_load(8'h55);

    check_load_monitor(8'h55);

    random_data1 = $urandom %256;
    check_load(random_data1);
    check_load_monitor(random_data1);
    $finish;
end

endmodule