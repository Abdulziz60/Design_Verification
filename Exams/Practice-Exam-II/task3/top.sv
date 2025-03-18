timeunit 1ns;
timeprecision 1ns;

`include "../task3/spi_slave_mem.sv"
`include "../task3/TB_spi_slave_mem.sv"


module top;

    logic cs;      // Active–low chip select
    logic sclk;    // Serial clock
    logic mosi;    // Master Out, Slave In
    logic miso;    // Master In, Slave Out

    logic clk;

spi_slave_mem ( .* );
TB_spi_slave_mem ( .* );




initial begin
    clk = 0;
    forever #5 clk = ~clk; // Toggle clock every 5 time units
end

// always @( cs ) begin
//   if ( cs === 0 ) begin 
//     for(int i = 0 ; i <= 32; i++)begin
//       sclk = 0;
//       #5 sclk = ~sclk;
//       if (cs === 1 )begin
//        sclk = 0;
//        i = 0;
//       end else begin
//         #5 sclk = ~sclk;
//       end
//     end
//   end else begin
//     sclk = 0;
//   end
// end

always begin
  if (cs === 0 )begin   
    #5 sclk = ~sclk;
  end else begin
    sclk = 0;
    @(cs); 
  end
end




initial begin
    #5000;
    $display("Out of the time !!!");
    $finish;
 end



endmodule