// constructor.sv
class counter;
    int count;

    function new(int value = 0);
        count = value;
    endfunction

    function void load(int value);
        count = value;
    endfunction

    function int getcount();
        return count;
    endfunction
endclass : counter

module constructor_tb;
    initial begin
        counter c1 = new(10);
        $display("Initial Count: %0d", c1.getcount());
    end
endmodule