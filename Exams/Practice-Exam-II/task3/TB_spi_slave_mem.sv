

module TB_spi_slave_mem (

    output  logic cs,      // Active–low chip select
    input   logic sclk,    // Serial clock
    output  logic mosi,    // Master In, Slave Out
    input   logic miso     // Master Out, Slave In
);


// Command codes
localparam SINGLE_WRITE = 3'b001;
localparam SINGLE_READ  = 3'b010;
localparam BURST_WRITE  = 3'b011;
localparam BURST_READ   = 3'b100;

// initial cs = 1;


// 1. Single Write-Read: Write a value via SPI, read it back
task write_read();
   


endtask


//2	Burst Write-Read	Write multiple values, read them back in order  Directed
task burst_writ_read();




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





initial begin
    $dumpfile("dumb.vcd");
    $dumpvars;


    cs = 1;
    #60;
    cs = 0;
    #60;
    cs = 1; 
    #80; 
    cs = 0;
    #10;
    cs = 1;
    #10;
    cs = 0;
    #160;
    cs = 1;


    // cs = 1;
end
 
 

endmodule