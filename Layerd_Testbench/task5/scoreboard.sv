
class scoreboard ;

    logic [8:0] expected_result;

    mailbox #(transaction) mbx;
    transaction trans;
  
    function new (mailbox #(transaction)mbx);
        this.mbx = mbx ;
        trans = new();
    endfunction

    task run();
        forever begin
           mbx.get(trans);
                expected_result = trans.a + trans.b;
                if( expected_result ==  trans.c ) 
                begin
                    $display("test pass:  a = %d, b = %d,  expected_result = %d, c = %d ",
                                             trans.a, trans.b,expected_result, trans.c);
                end 
                else
                begin
                    $display("test failed!!! : expected_result = %d, c = %d",expected_result, trans.c );

                end
            end
    endtask

endclass //scoreboard 