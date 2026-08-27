//////// USING SOFT CONSTRAINT/////////
class packet;
  rand bit[3:0] a;
  constraint addr_a { a>5;}
endclass

module with_soft;
  packet pkt;
  int check;
  initial begin
    pkt = new();
    $display("----------------With soft-------------------");
    
    for(int i = 0; i<5; i++) begin
      check = pkt.randomize();
      if(check == 1)
        $display(" Value of a = %0d",pkt.a);//Display a>5
      else
        $display("Randomization failed");
    end
    
    for (int i = 0; i<5; i++) begin
      check = pkt.randomize() with {soft a<10;};
      if(check == 1)
        $display(" Value of a = %0d",pkt.a);//Display 5<a<10 // When no  conflict both constraint are parallely work.
      else
        $display("Randomization failed");
    end
    
    for (int i = 0; i<5; i++) begin
      check = pkt.randomize() with {soft a==4;};
      if(check == 1)
        $display(" Value of a = %0d",pkt.a);// soft constraint is ignored when conflict happens
      else
        $display("Randomization failed");
    end
  end
endmodule

//OUTPUT
# KERNEL: ----------------With soft-------------------
# KERNEL:  Value of a = 8
# KERNEL:  Value of a = 12
# KERNEL:  Value of a = 10
# KERNEL:  Value of a = 8
# KERNEL:  Value of a = 12
# KERNEL:  Value of a = 6
# KERNEL:  Value of a = 8
# KERNEL:  Value of a = 7
# KERNEL:  Value of a = 6
# KERNEL:  Value of a = 9
# KERNEL:  Value of a = 6
# KERNEL:  Value of a = 13
# KERNEL:  Value of a = 11
# KERNEL:  Value of a = 14
# KERNEL:  Value of a = 15
