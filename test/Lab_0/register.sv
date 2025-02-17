module register (
    input        enable,
    input        clk,
    input  [7:0] data,
    input        rst_,   // Active-low reset
    output reg [7:0] out
);

    // Register behavior with active-low asynchronous reset
    always @(posedge clk or negedge rst_) begin
        if (!rst_) 
            out <= 8'b0;          // Reset output to 0 when rst_ is low
        else if (enable)
            out <= data;          // Load data into out when enabled
    end

endmodule
