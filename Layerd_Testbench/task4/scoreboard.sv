
class scoreboard ;
    
    bit [7:0] a,b;
    logic [8:0] c;
    logic [8:0] expected_result;

    transaction trans;
    virtual adder_if vif;

    function new (virtual adder_if vif);
        this.vif = vif ;
        trans = new();
    endfunction

    task run();
        forever begin
            @(vif.a, vif.b, vif.c);
                trans.a = vif.a;
                trans.b = vif.b;
                trans.c = vif.c;

                expected_result = trans.a + trans.b;
                if( expected_result ==  trans.c ) begin
                    $display("test pass:  a = %d, b = %d,  expected_result = %d, c = %d ",
                                             trans.a, trans.b,expected_result, trans.c);
                end 
                else begin
                    $display("test failed!!! : expected_result = %d, c = %d",expected_result, trans.c );

                end
            end
    endtask

endclass //scoreboard 