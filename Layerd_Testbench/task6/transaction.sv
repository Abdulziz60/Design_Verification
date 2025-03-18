class transaction ;
    randc bit [7:0] a,b;
    logic [8:0] c;

    function transaction copy ();
        copy = new ();
        copy.a = this.a;
        copy.b = this.b;
        copy.c = this.c;
    endfunction

    function void display();

        $display("a = %d, b = %d , c = %d", a, b, c);
        
    endfunction

endclass