// Overriding class members ex2
class packet;
  string pkt_type;
  int data;
  int addr;
  
  function new();
    pkt_type ="GOOD PKT";
    data = 10;
    addr = 20;
  endfunction
  
  function void display();
    $display("pkt_type = %s, data= %0d addr = %0d",pkt_type, data, addr);
  endfunction
endclass

//child-1
class child_1 extends packet;
  string pkt_type;
  int data; //properties overide here
  
  function new();
    pkt_type = "GOOD PKT";
    data = 25;
  endfunction
  
  function void display(); //display method override here
    $display("pkt_type=%s,\t data=%0d",pkt_type,data);
  endfunction
endclass

//child-2
class child_2 extends packet;
  string Team;
  int members;
  
  function new();
    pkt_type ="Good";
    addr = 35;
  endfunction
  
  function void display(); //display method override here
    $display("pkt_type=%0s,\t data=%0d,\t addr=%0d",pkt_type,data,addr);
  endfunction
endclass

module over_riding;
  child_2 c;

  initial begin:BEGIN_I
    c=new();
    $display("contents before over-riding");
    c.display();
    c.pkt_type = "signal";
    c.data=60;
    $display("contents after over-riding");
    c.display();
  end
endmodule
