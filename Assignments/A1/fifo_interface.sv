interface fifo_interface #(parameter DATA_WIDTH = 8, DEPTH = 8) (input logic clk, input logic rst_n);
  
    logic w_en, r_en;
    logic [DATA_WIDTH-1:0] data_in;
    logic [DATA_WIDTH-1:0] data_out;
    logic full, empty;

    // Tasks for writing and reading from FIFO
    task fifo_write(input logic [DATA_WIDTH-1:0] w_data);
        @(posedge clk);
        if (!full) begin
            w_en = 1;
            data_in = w_data;
        end
        
        @(posedge clk);
        w_en = 0; // Deassert write enable
    endtask

    task fifo_read(output logic [DATA_WIDTH-1:0] r_data);
        @(posedge clk);
        if (!empty) begin
            r_en = 1;
        end

        @(posedge clk);
        r_en = 0; // Deassert read enable

        @(posedge clk);
        r_data = data_out;
    endtask

endinterface
