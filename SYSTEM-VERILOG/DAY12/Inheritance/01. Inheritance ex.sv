// Inheritance
class parent_trans;
  bit [31:0] data;
  
  function void disp_p();
    $display("Value of data = %0d", data);
  endfunction
endclass

class child_trans extends parent_trans;
  int id;
  
  function void disp_c();
    $display("Value of id = %0d",id);
  endfunction 
endclass

module inherit;
  initial begin
    child_trans c_tr;
    c_tr = new();
    c_tr.data = 5;
    c_tr.id = 1;
    c_tr.disp_p();
    c_tr.disp_c();
  end
endmodule
