module and_ff (
    input logic clk, 
    input logic rst_n, 
    input logic enable, 
    input logic a, 
    input logic b, 
    output logic z
);

    logic a_and_b;

    assign a_and_b = a & b;
    always_ff @(posedge clk) begin 
        if(rst_n)
            z <= 0;
        else z <= a_and_b;    
    end

    

endmodule