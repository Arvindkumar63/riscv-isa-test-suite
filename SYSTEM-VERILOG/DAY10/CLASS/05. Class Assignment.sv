// Class Assignment
class transaction;
  bit [31:0] data;
endclass

module class_assign;
  transaction tr1, tr2;
  initial begin
    tr1 = new();
    tr1.data = 5;
    tr2 = tr1; // Class Assignment 
    // data can change by handle tr1 and tr2
    $display("tr1.data = %0d | tr2.data = %0d", tr1.data, tr2.data);
    
    tr2.data = 10;
    $display("tr1.data = %0d | tr2.data = %0d", tr1.data, tr2.data);
  end
endmodule
