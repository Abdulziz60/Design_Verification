`include "../task1/piso.sv"
`include "../task1/TB_piso.sv"


module top;

    logic       clk;
    logic       rst_n;
    logic       load;
    logic [7:0] data_i;
    logic       serial_o;

    initial clk = 0;
    always #5 clk = ~clk;

    piso_shift_reg DUT_piso_shift_reg(.*);

    TB_piso DUT_TB_piso(.*);

    

endmodule