module adder ( 
    input  logic clk,
    input  logic [7:0] a,
    input  logic [7:0] b,
    output logic [7:0] sum,
    output logic Carry
);
    always_ff @( posedge clk )
    begin
        {Carry,sum} <= a + b ;
    
    end

endmodule