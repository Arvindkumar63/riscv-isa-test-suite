// Static methods
// The static method tries to access the non-static variable of the class, which leads to a compilation error.
class packet;
  byte packet_id;    
  //static property to keep track of number of pkt's created
  static byte no_of_pkts_created;
  
  function new();
    packet_id = ++no_of_pkts_created;
  endfunction
  
  //static method only access static property
  static function void display();
    $display("--------------------------------------");
    //$display("\t packet_id  = %0d",packet_id);//Illegal to access non-static property 'packet_id' from a static method.
    $display("\t no_of_pkts_created  = %0d",no_of_pkts_created);
    $display("--------------------------------------");
  endfunction 
endclass

module static_methods;
  packet pkt1;
  packet pkt2;

  initial begin
    $display("--------------------------------------");
   // null ref handle $display("%0d",pkt1.packet_id);
    $display("Access before object creation: %0d",pkt1.no_of_pkts_created);// access the static properties before creating the object
    $display("--------------------------------------");
    pkt1 = new();
    pkt1.display();
    pkt2 = new();
    pkt1.display();
    pkt2.display();
  end  
endmodule
