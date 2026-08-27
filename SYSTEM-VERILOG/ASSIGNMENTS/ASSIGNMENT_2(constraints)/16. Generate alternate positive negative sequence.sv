// Generate alternate positive negative sequence: 5, -10, 15, -20, 25, -30.
class cons_16;
  rand int val[10];
  constraint c16{ 
    foreach(val[i]) 
      val[i] == (i+1)*5*((i%2==0)?1:-1);    
  }
endclass

module constraint_16;
  cons_16 c1 = new();
  initial begin
    c1.randomize();
    $display("val = %0p", c1.val);
  end
endmodule

//OUTPUT
val = 5 -10 15 -20 25 -30 35 -40 45 -50
