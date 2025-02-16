interface mem_interface(input logic clk);
    logic [7:0] addr;      // Address Bus
    logic [15:0] data_in;  // Data input
    logic [15:0] data_out; // Data output
    logic read, write;     // Read/Write control signals

    // Modports (Add clk to mem_mp)
    modport mem_mp (
        input clk, addr, data_in, read, write,
        output data_out
    );

    modport tb_mp (
        input clk,
        output addr, data_in, read, write,
        input data_out
    );

    // Interface Methods
    task write_mem(input logic [7:0] a, input logic [15:0] d);
        addr = a;
        data_in = d;
        write = 1;
        #10;
        write = 0;
    endtask

    task read_mem(input logic [7:0] a, output logic [15:0] d);
        addr = a;
        read = 1;
        #10;
        d = data_out;
        read = 0;
    endtask
endinterface
