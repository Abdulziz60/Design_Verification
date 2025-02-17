class base_class;
    function void display();
        $display("Inside base class");
    endfunction
endclass

class derived_class extends base_class;
    function void display();
        $display("Inside derived class");
    endfunction
endclass
