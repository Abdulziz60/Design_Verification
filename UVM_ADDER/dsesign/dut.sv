module adder (dut_if aif);
 
    always @(posedge aif.clk) begin
        {aif.carry , aif.sum} = aif.a + aif.b;

        `uvm_info("DUT :" , $sformatf("a = %d, b = %d, sum = %d, carry = %d ",aif.a, aif.b, aif.sum, aif.carry),UVM_HIGH);
        
    end

endmodule