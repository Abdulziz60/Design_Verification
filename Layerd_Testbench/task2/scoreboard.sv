
class scoreboard ;
    
    bit [7:0] a,b;

    logic [8:0] c;

    logic [8:0] expected_result;

    virtual adder_if vif;

    function new (virtual adder_if vif);
        
        this.vif = vif ;

    endfunction


    task run();

    forever begin
    @(vif.a, vif.b, vif.c);
            a = vif.a;
            b = vif.b;
            c = vif.c;
            expected_result = a + b;
            if( expected_result == c ) begin
                $display("test pass:  a = %d, b = %d,  expected_result = %d, c = %d ",
                                         a, b,expected_result, c);
            end else begin
                $display("test failed!!! : expected_result = %d, c = %d",expected_result, c );

        end
    end

    endtask

endclass //scoreboard 