// static_members.sv
class upcounter;
    static int instance_count;

    function new();
        instance_count++;
    endfunction

    static function int get_instance_count();
        return instance_count;
    endfunction
endclass : upcounter

module static_members_tb;
    initial begin
        upcounter uc1 = new();
        upcounter uc2 = new();
        upcounter uc3 = new();
        upcounter uc4 = new();
        $display("Instances Created: %0d", upcounter::get_instance_count());
    end
endmodule