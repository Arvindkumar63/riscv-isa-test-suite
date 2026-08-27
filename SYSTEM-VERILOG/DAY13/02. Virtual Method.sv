// Virtual method
//---------- Method Without virtual keyword-----------
class base_class;
  function void display();
    $display("INSIDE BASE CLASS");
  endfunction
endclass

class extended_class extends base_class;
     function void display();
       $display("INSIDE EXTENDED CLASS");
  endfunction
endclass        

module without_virtual;
  initial begin
    base_class b_c;
    extended_class e_c;
    e_c = new();
    b_c = e_c;
    b_c.display(); // Expected o/p : INSIDE BASE CLASS
  end
endmodule

//---------- Method With virtual keyword-----------
class base_class;
  virtual function void display();
    $display("INSIDE BASE CLASS");
  endfunction
endclass

class extended_class extends base_class;
     function void display();
       $display("INSIDE EXTENDED CLASS");
  endfunction
endclass        

module with_virtual;
  initial begin
    base_class b_c;
    extended_class e_c;
    e_c = new();
    b_c = e_c;
    b_c.display(); // Expected o/p : INSIDE EXTENDED CLASS
  end
endmodule
