// counter_limits.sv
class counter;
    int count, max, min;

    function new(int value = 0, int min_val = 0, int max_val = 100);
        min = min_val;
        max = max_val;
        check_set(value);
    endfunction

    function void check_set(int value);
        if (value < min || value > max) begin
            count = min;
            $display("Warning: Value out of bounds. Reset to min: %0d", min);
        end else
            count = value;
    endfunction

    function void load(int value);
        check_set(value);
    endfunction

    function int getcount();
        return count;
    endfunction
endclass : counter

module counter_limits_tb;
    initial begin
        counter c1 = new(5, 0, 10);
        c1.load(4);
        $display("Count: %0d", c1.getcount());
    end
endmodule