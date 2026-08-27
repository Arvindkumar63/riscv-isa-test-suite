// Check for null memory
class transaction;
  bit [31:0] data;
  int id;
endclass

module class_example;
  transaction tr1, tr2;
  initial begin
    tr1 = new();
    
    //------------Check for null memory----------------
    if(tr1 != null) begin // string "null" is not expected
    tr1.data = 5;
    tr1.id = 1;
    $display("Object pkt1.data = %0h, id = %0h", tr1.data, tr1.id);
    end
    else $display("tr1 object is not created");
    
    
    //----------------NULL pointer dereference error--------------
//     tr2.data = 10; // no memory allocated.. So error occur
//     tr2.id = 2;
//     $display("Object pkt2.data = %0h, id = %0h", tr2.data, tr2.id);
    
    //------------Check for null memory----------------
    if(tr2 != null) begin // string "null" is not expected
    tr2.data = 10;
    tr2.id = 2;
      $display("Object pkt2.data = %0h, id = %0h", tr2.data, tr2.id);
    end
    else $display("tr2 object is not created");
  end
endmodule
