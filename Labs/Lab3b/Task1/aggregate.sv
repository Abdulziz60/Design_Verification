class sub_module;
    function void process();
        $display("Processing inside sub-module");
    endfunction
endclass

class main_module;
    sub_module sm;

    function new();
        sm = new();
    endfunction

    function void execute();
        sm.process();
    endfunction
endclass
