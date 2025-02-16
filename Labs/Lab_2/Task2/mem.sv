module mem(mem_interface.mem_mp mem_if);
    logic [15:0] mem_array [0:255]; // 256 x 16-bit memory

    always_ff @(posedge mem_if.clk) begin
        if (mem_if.write)
            mem_array[mem_if.addr] <= mem_if.data_in;
        else if (mem_if.read)
            mem_if.data_out <= mem_array[mem_if.addr];
    end
endmodule
