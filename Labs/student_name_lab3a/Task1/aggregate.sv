// aggregate.sv
class upcounter;
    int count;
    int max, min;
    bit carry;

    function new(int value = 0, int min_val = 0, int max_val = 59);
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
    endfunction

    function int getcount();
        return count;
    endfunction
endclass : upcounter

class timer;
    upcounter hours, minutes, seconds;

    function new(int h = 0, int m = 0, int s = 0);
        hours = new(h, 0, 23);
        minutes = new(m, 0, 59);
        seconds = new(s, 0, 59);
    endfunction

    function void next();
        seconds.next();
        if (seconds.carry)
            minutes.next();
        if (minutes.carry)
            hours.next();
        $display("%0d:%0d:%0d", hours.getcount(), minutes.getcount(), seconds.getcount());
    endfunction
endclass : timer

module aggregate_tb;
    initial begin
        timer t = new(23, 58, 59);
        t.next();
        t.next();
    end
endmodule
