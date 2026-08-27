//Generate even numbers between 10 and 30.
class cons_17;
  rand int value[10];
  constraint c17{ 
    foreach(value[i])
      value[i] inside {[10:30]};
  }
  constraint c1{
    foreach(value[i])
      value[i]%2 == 0;
  }
endclass
  
module constraint_17;
  cons_17 c2 = new();
  initial begin
    c2.randomize();
    $display("value = %0p ", c2.value);
  end
endmodule



//OUTPUT
value = 14 18 30 26 16 14 26 22 28 18 
