timeunit 1ns;
timeprecision 1ns;

`include "../task3/spi_slave_mem.sv"
`include "../task3/TB_spi_slave_mem.sv"


module top;

    logic cs;      // Active–low chip select
    logic sclk;    // Serial clock
    logic mosi;    // Master Out, Slave In
    logic miso;    // Master In, Slave Out

spi_slave_mem ( .* );
TB_spi_slave_mem ( .* );




initial sclk = 0;
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

    $display("Out of the time !!!");
    #500;
    $finish;
 end



endmodule