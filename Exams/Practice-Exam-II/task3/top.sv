timeunit 1ns;
timeprecision 1ns;

`include "../task3/spi_slave_mem.sv"
`include "../task3/TB_spi_slave_mem.sv"


module top;

    logic cs;      // Active–low chip select
    logic sclk;    // Serial clock
    logic mosi;    // Master Out, Slave In
    logic miso;    // Master In, Slave Out


initial sclk = 0;
  always #5 sclk = ~sclk;

spi_slave_mem ( .* );
TB_spi_slave_mem ( .* );

endmodule