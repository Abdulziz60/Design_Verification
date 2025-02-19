module tb_multiplier_32x32;

    logic [31:0] a, b;
    logic [63:0] product;
    
    // Instantiate DUT
    multiplier_32x32 dut (
        .a(a),
        .b(b),
        .product(product)
    );

    // Functional Coverage
    covergroup cg_mult;
        coverpoint a {
            bins zero = {32'h00000000};
            bins max = {32'hFFFFFFFF};
            bins min = {32'h80000000};
            bins small_range[] = {[32'h00000001:32'h00000010]};
            bins large_range[] = {[32'hFFFFFFF0:32'hFFFFFFFF]};
        }
        
        coverpoint b {
            bins zero = {32'h00000000};
            bins max = {32'hFFFFFFFF};
            bins min = {32'h80000000};
            bins small_range[] = {[32'h00000001:32'h00000010]};
            bins large_range[] = {[32'hFFFFFFF0:32'hFFFFFFFF]};
        }
        
        cross a, b;
    endgroup

    cg_mult cov_inst = new();

    // Constrained Random Testing
    initial begin
     /*   int i;
        for (i = 0; i < 10000; i++) begin
            a = $random;
            b = $random;
            #10;
            cov_inst.sample();
        end*/

        // Apply Corner Cases
        a = 32'h00000000; b = 32'h00000000; cov_inst.sample();#10;
        a = 32'h00000001; b = 32'h00000001; cov_inst.sample();#10;
        a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; cov_inst.sample();#10;
        a = 32'h80000000; b = 32'h00000001; cov_inst.sample();#10;
        a = 32'h7FFFFFFF; b = 32'h7FFFFFFF; cov_inst.sample();#10;
        a = 32'h0000FFFF; b = 32'h0000FFFF; cov_inst.sample();#10;
        a = 32'hFFFF0000; b = 32'hFFFF0000; cov_inst.sample();#10;
        cov_inst.sample();
        // Display Coverage
        $display("Coverage: %f%%", $get_coverage());
        $finish;
    end

   /* // Assertion to check correct multiplication
    property check_multiplication;
        @(posedge a or posedge b) product == (a * b);
    endproperty

    assert property (check_multiplication)
    else $error("Mismatch in multiplication!");
*/
endmodule
