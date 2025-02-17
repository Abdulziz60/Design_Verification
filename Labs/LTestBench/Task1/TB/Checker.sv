class Checker1;

        trans T; 

        virtual adder_if aif;

        function  new (virtual adder_if aif, mailbox #(trans) mbx ) ;
                    
            this.aif = aif;

        endfunction

        //gnerate signals and apply them to DUT usinf interface

        task run ();
            forever
            begin  
                        @(aif.a, aif.b, aif.c );
                        $display("Monitor");
                        $display("a = %d, b = %d, c = %d ", aif.a, aif.b, aif.c );
                        if ((aif.a + aif.b) != aif.c)
                                $display("Test Failed");
                        else 
                                $display("Test Passed");
                        
                        
            end

        endtask

endclass //