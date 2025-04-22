module top;

  // import the UVM library
  import uvm_pkg::*;
  
  // include the UVM macros
  `include "uvm_macros.svh"

  // import the YAPP package
  import yapp_pkg::*;

  // generate 5 random packets and use the print method
  // to display the results

  initial begin
    yapp_packet pkt;
    yapp_packet pkt_copy;

    for (int i = 0; i < 5; i++) begin
      pkt = yapp_packet::type_id::create($sformatf("pkt_%0d", i));
      
      if (!pkt.randomize())
        `uvm_error("RANDOMIZATION", $sformatf("Failed to randomize packet %0d", i))
      else begin
        $display("======= Packet %0d =======", i);
        
        // default printer (table)
        pkt.print();

        // tree printer
        pkt.print(uvm_default_tree_printer);

        // line printer
        pkt.print(uvm_default_line_printer);

        // experiment with the copy, clone and compare UVM method
        //pkt_copy = pkt.clone();
        if (!$cast(pkt_copy, pkt.clone()))
            `uvm_error("CAST", "Failed to cast cloned object to yapp_packet");


        if (!pkt.compare(pkt_copy))
          `uvm_error("COMPARE", "Original and cloned packet are different!");
      end
    end

    $finish;
  end

endmodule : top

