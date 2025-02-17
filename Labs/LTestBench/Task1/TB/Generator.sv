// `include "/home/Abdulaziz_Salem/CX-301-DesignVerification/Labs/LTestBench/Task1/TB/trans.sv"
class Generator;

        rand trans T; 
        event done ;
        mailbox #(trans) mbx; //create a mailbox to hold transactions 
        


        function  new (mailbox #(trans) mbx1);
            this.mbx = mbx1;
            T = new();
        endfunction


        task run ();
            
            for (int i=0 ; i<5 ; i++)
            begin
                if(!randomize())
                    $display("Randmoization Failed");
                else
                begin
                    mbx.put(T);

                    #1;
                end
            end
            ->done;

        endtask

endclass //Generator
