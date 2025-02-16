timeunit 1ns;
timeprecision 100ps;
module register (
    input        enable,
    input        clk,
    input  [7:0] data,
    input        rst_,   
    output reg [7:0] out
);

    always @(posedge clk or negedge rst_) begin
        if (!rst_) 
            out <= 8'b0;          
        else if (enable)
            out <= data;         
    end

endmodule
