// roll_over_under.sv
class upcounter;
    int count, max, min;
    bit carry;

    function new(int value = 0, int min_val = 0, int max_val = 10);
        min = min_val;
        max = max_val;
        count = value;
        carry = 0;
    endfunction

    function void next();
        if (count == max) begin
            count = min;
            carry = 1;
        end else begin
            count++;
            carry = 0;
        end
        $display("Up Counter: %0d, Carry: %b", count, carry);
    endfunction
endclass : upcounter

module roll_over_under_tb;
    initial begin
        upcounter uc = new(9, 0, 9);
        uc.next();
        uc.next();
    end
endmodule
