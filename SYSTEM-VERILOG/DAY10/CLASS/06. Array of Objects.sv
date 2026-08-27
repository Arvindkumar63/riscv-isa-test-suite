// Array of Objects
class transaction;
  bit[31:0] data;
  int id;
endclass


// Fixed Array of Objects
module array_ex;
  transaction tr[5];
  initial begin
    foreach(tr[i]) begin
      tr[i] = new();
      tr[i].data = i*i;
      tr[i].id = i+1;
    end
    
    foreach(tr[i]) 
      $display("tr[%0d].data = %0d, tr[%0d].id = %0d",i, tr[i].data, i, tr[i].id);
  end
endmodule
      
//Dynamic Array of Objects
module array_ex;
  transaction tr[];
  initial begin
    tr = new[5];
    foreach(tr[i]) begin
      tr[i] = new();
      tr[i].data = i*i;
      tr[i].id = i+1;
    end
    
    foreach(tr[i]) 
      $display("tr[%0d].data = %0d, tr[%0d].id = %0d",i, tr[i].data, i, tr[i].id);
  end
endmodule

//Associative Array of Objects
typedef enum{TRANS, RECEIVE, REPEAT} tr_type;
module arrray_ex;
  transaction tr[tr_type];
  initial begin
    tr[TRANS] = new();
    tr[RECEIVE] = new();
    tr[REPEAT] = new();
    
    foreach(tr[i]) begin
      tr[i].data = i*i;
      tr[i].id = i+1;
    end
    
    foreach(tr[i]) 
      $display("tr[%0d].data = %0d, tr[%0d].id = %0d",i, tr[i].data, i, tr[i].id);
  end
endmodule
