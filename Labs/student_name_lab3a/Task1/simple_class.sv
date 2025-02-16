// simple_class.sv
class counter;
    int count;

    function void load(int value);
        count = value;
    endfunction

    function int getcount();
        return count;
    endfunction

endclass : counter

module simple_class_tb;
    initial begin
        counter c1 = new();
        c1.load(5);
        $display("Count: %0d", c1.getcount());
    end
endmodule