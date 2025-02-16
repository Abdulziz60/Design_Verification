module mem_test (
  input  logic       clk, 
  output logic       read, 
  output logic       write, 
  output logic [4:0] addr, 
  output logic [7:0] data_in,
  input  wire  [7:0] data_out
);
timeunit 1ns;
timeprecision 1ns;

bit debug = 1;
logic [7:0] rdata;
int error_status = 0;

initial begin
    $display("Clear Memory Test");
    for (int i = 0; i < 32; i++)
        write_mem(i, 8'h00, debug);
    #10;
    for (int i = 0; i < 32; i++) begin
        read_mem(i, rdata, debug);
        if (rdata !== 8'h00) begin
            error_status++;
            $display("ERROR at Addr %0d: Expected 00, Got %0h", i, rdata);
        end
    end
    if (error_status == 0)
        $display("Clear Memory Test PASSED");
    else
        $display("Clear Memory Test FAILED with %0d errors", error_status);
    
    $display("Data = Address Test");
    for (int i = 0; i < 32; i++)
        write_mem(i, i, debug);
    #10;
    for (int i = 0; i < 32; i++) begin
        read_mem(i, rdata, debug);
        if (rdata !== i) begin
            error_status++;
            $display("ERROR at Addr %0d: Expected %0h, Got %0h", i, i, rdata);
        end
    end
    if (error_status == 0)
        $display("Data = Address Test PASSED");
    else
        $display("Data = Address Test FAILED with %0d errors", error_status);
    $finish;
end

task write_mem(input [4:0] wr_addr, input [7:0] wr_data, input bit dbg);
    @(negedge clk);
    addr = wr_addr;
    data_in = wr_data;
    write = 1;
    read = 0;
    @(posedge clk);
    write = 0;
    if (dbg) 
        $display("WRITE: Addr=%0d, Data=%0h", wr_addr, wr_data);
endtask

task read_mem(input [4:0] rd_addr, output [7:0] rd_data, input bit dbg);
    @(negedge clk);
    addr = rd_addr;
    write = 0;
    read = 1;
    @(posedge clk);
    #1;
    rd_data = data_out;
    read = 0;
    if (dbg) 
        $display("READ: Addr=%0d, Data=%0h", rd_addr, rd_data);
endtask

endmodule