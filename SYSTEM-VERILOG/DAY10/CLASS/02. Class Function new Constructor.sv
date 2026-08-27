// Class Function new Constructor
class transaction;
  bit [31:0] data;
  int id;
  
  function new (bit [31:0] m_data); // New Constructor 
    $display("Inside constructor");
    data = m_data;
    id = 10;
  endfunction
endclass

module class_example;
  transaction tr;
  initial begin
    tr = new(10);
    $display("Value of data = %0d | id = %0d", tr.data, tr.id);
  end
endmodule
