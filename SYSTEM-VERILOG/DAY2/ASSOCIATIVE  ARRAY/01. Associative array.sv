// ASSOCIATIVE ARRAY
module associative_array;
  typedef enum {TRANS, RECEIVE, REPEATER} tr_type;
  bit [7:0] array_enum [tr_type];
  bit [7:0] array_int[int];
  initial begin
    array_enum[TRANS] = 10;
    array_enum[RECEIVE] = 20;
    array_enum[REPEATER] = 30;
    
    foreach(array_enum[i])  begin   
      $display("array_enum[%s] = %0d", i.name(),array_enum[i]); 
    end
    array_int[5] = 2;
    array_int[10] = 4;
    array_int[7] = 6;
    foreach(array_int[i])  begin   
      $display("array_int[%0d] = %0d",i,array_int[i]); 
    end
  end     
endmodule 
