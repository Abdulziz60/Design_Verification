// `include "/home/Abdulaziz_Salem/CX-301-DesignVerification/Labs/LTestBench/Task1/TB/trans.sv"
class Driver;

        trans T; 
        mailbox #(trans) mbx ;
        virtual adder_if aif;

        function  new (virtual adder_if aif, mailbox #(trans) mbx ) ;
                    //mbx1
            this.mbx = mbx;
            this.aif = aif;
            T = new();
        endfunction

        //gnerate signals and apply them to DUT usinf interface

        task run ();
            forever
            begin  
                     mbx.get(T); //getting the transaction from the mailbox 

                     $display("Driver : ");
                     T.display();

                    aif.a = T.a;
                    aif.b = T.b;
                    #1;
                
            end

        endtask

endclass //Driver