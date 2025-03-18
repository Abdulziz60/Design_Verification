

module TB_spi_slave_mem (

    input   logic clk, 
    output  logic cs,      // Active–low chip select
    input   logic sclk,    // Serial clock
    output  logic mosi,    // Master In, Slave Out
    input   logic miso     // Master Out, Slave In
);

logic [7:0] received_data;

initial begin
cs = 1;
mosi = 0;

end

// 1. Single Write : Write a value via SPI, read it back
task write_data (input logic [7:0] write_add, input logic [7:0] data_in);
    @(negedge clk);
    cs <= 0;
    @(posedge sclk);
    for(int i = 7; i >= 5; i-- ) begin //inst
        mosi <= write_add[i];
        @(negedge sclk);
        $display("inst mosi = %0b , time: %0t", mosi, $time);
    end
    for(int i = 4; i >= 0; i--) begin // address
        mosi <= write_add[i];
        @(negedge sclk);
        $display("addr mosi = %0b , time: %0t", mosi, $time);
    end
    for (int i = 7; i >= 0; i--) begin //data 
        mosi <= data_in[i];
        @(negedge sclk);
        $display("data mosi = %0b , time: %0t", mosi, $time);
    end
    $display("✅ Write: Address = %0b, Data = %0b, Time = %0t", write_add[4:0], data_in, $time);

    $display("------------ Write Data Done ---------------");
    @(posedge clk);
    cs <= 1;
    #10;
endtask

//1. Single read : read the data back.
task read_data (input logic [7:0] read_add, output logic [7:0] data_out);
    @(posedge clk);
    cs <= 0;
    @(posedge sclk);
    for(int i = 7; i >= 5; i-- ) begin //inst
        mosi <= read_add[i];
        @(posedge sclk);
        $display("inst mosi = %0b , time: %0t", mosi, $time);
    end
    for(int i = 4; i >= 0; i--) begin // address
        mosi <= read_add[i];
        @(posedge sclk);
        $display("addr mosi = %0b , time: %0t", mosi, $time);
    end
    for (int i = 7; i >= 0; i--) begin
        @(posedge sclk);  
        data_out[i] = miso; // Read from SPI slave
        $display("data miso = %0b , time: %0t", miso, $time);
    end
    $display("✅ Read: Address = %0b, Data = %0b, Time = %0t", read_add[4:0], data_out, $time);
    
    $display("------------ Read Data Done ---------------");
    @(posedge clk);
    cs <= 1;
    #10;
endtask


//2	Burst Write: Write multiple values.
task burst_write(input logic [7:0] start_addr, input logic [7:0] data_array [0:15]);
    @(negedge clk);
    cs <= 0;  // Activate SPI
    @(posedge sclk);

    // **Send Instruction (`011xxxxx` where xxxxx = address)**
    mosi <= 0; @(posedge sclk); // 0
    mosi <= 1; @(posedge sclk); // 1
    mosi <= 1; @(posedge sclk); // 1

    // **Send 5-bit Address**
    for (int i = 4; i >= 0; i--) begin
        mosi <= start_addr[i];
        @(posedge sclk);
    end

    // **Send Data Bytes Sequentially**
    for (int j = 0; j < 16; j++) begin
        if (cs == 1 || start_addr + j > 8'h1F) break; // Stop if CS is deasserted or max address reached

        for (int i = 7; i >= 0; i--) begin
            mosi <= data_array[j][i];
            @(posedge sclk);
        end

        $display("Burst Write: Address = %0b, Data = %0b, Time = %0t", start_addr + j, data_array[j], $time);
    end

    @(negedge clk);
    $display("Burst Write is done ...");
    cs <= 1; // Deactivate SPI
    #10;
endtask



//2	Burst Read : read them back in order  Directed.
task burst_read();




endtask


//3	Invalid Command	Send an unused instruction, check response  Directed
task invalid_command ();



endtask



//4	CS Handling	Deassert CS during a transaction, check behavior    Directed
task CS_handling ();



endtask


//5	Random SPI Test	Perform random SPI read/write operations    Randomized
task random_SPI_test ();



endtask



    logic [7:0] data_stream [0:15] = '{8'hA1, 8'hB2, 8'hC3, 8'hD4, 8'hE5, 8'hF6, 8'h12, 8'h34,
                                       8'h56, 8'h78, 8'h9A, 8'hBC, 8'hDE, 8'hF0, 8'hAB, 8'hCD};
    
   

initial begin
    // burst_write(8'h10, data_stream);
    write_data( 8'b00100001, 8'b00000001);
    #50;
    read_data(8'b01000001,received_data);

   
end
 
 initial begin

    $dumpfile("dumb.vcd");
    $dumpvars;
 end

endmodule