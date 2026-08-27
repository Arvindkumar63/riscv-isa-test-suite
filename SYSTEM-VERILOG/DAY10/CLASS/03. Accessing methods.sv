// Accessing class methods
class transaction;
  bit [31:0] data;
  int id;
  
  task update(bit [31:0] m_data, int m_id);//method 1
    data = m_data;
    id = m_id;
  endtask
  
  function void print(transaction tr);// method 2
    $display("Value of data = %0h and id = %0h", tr.data, tr.id);
  endfunction
endclass

module class_example;
  transaction tr;
  initial begin
    tr = new();
    tr.update(5, 9);
    tr.print(tr);
  end
endmodule
