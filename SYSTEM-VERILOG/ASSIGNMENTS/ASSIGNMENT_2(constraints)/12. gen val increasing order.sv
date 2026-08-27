// Write a constraint to generate values in increasing order.
class cons_12;
  rand bit [4:0] data[10];
  
  constraint c12{ foreach(data[i])
    if(i<9) 
      data[i]<data[i+1] ;}
endclass

module constraint_12;
  cons_12 c1 = new();
  initial begin
    c1.randomize();
    foreach(c1.data[i]) begin
      $display("data[%0d] = %0d",i,c1.data[i]);
    end
  end
endmodule


//OUTPUT
data[0] = 0
data[1] = 6
data[2] = 8
data[3] = 14
data[4] = 15
data[5] = 16
data[6] = 20
data[7] = 21
data[8] = 26
data[9] = 29
