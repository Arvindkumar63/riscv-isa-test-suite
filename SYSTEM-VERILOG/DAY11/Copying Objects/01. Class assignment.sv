// Copying Objects - Class Assignment
class packet;
  bit [31:0] addr;
  bit [31:0] data;
  bit write;
  string pkt_type;
 
  function new();
    addr  = 32'h10;
    data  = 32'hFF;
    write = 1;
    pkt_type = "GOOD_PKT";
  endfunction

  function void display();
    $display("---------------------------------------------------------");
    $display("\t addr  = %0h",addr);
    $display("\t data  = %0h",data);
    $display("\t write = %0d",write);
    $display("\t pkt_type  = %0s",pkt_type);
    $display("---------------------------------------------------------");
  endfunction
endclass

module class_assignment;
  packet pkt_1;
  packet pkt_2;

  initial begin
    pkt_1 = new();
    $display("-------------  calling pkt_1 display  ------------");
    pkt_1.display();
    //assigning pkt_1 to pkt_2
    pkt_2 = pkt_1;
    $display("-------------  calling pkt_2 display  ----------");
    pkt_2.display();
    
    //Any update to a variable from either of the classes will have impact on the other class.
    pkt_2.addr = 32'hAB;
    pkt_1.data  = 32'hAB;
    pkt_2.pkt_type = "BAD_PKT";
    $display("-------------  calling pkt_1 display  ----------");
    pkt_1.display();
    $display("-------------  calling pkt_2 display  ----------");
    pkt_2.display();
  end
endmodule
