////////WITHOUT USING SOFT CONSTRAINT/////////
class packet;
  rand bit[3:0] a;
  constraint addr_a { a>5;}
endclass

module without_soft;
  packet pkt;
  int check;
  initial begin
    pkt = new();
    $display("----------------Without soft-------------------");
    
    for(int i = 0; i<5; i++) begin
      check = pkt.randomize();
      if(check == 1)
        $display(" Value of a = %0d",pkt.a);//Display a>5
      else
        $display("Randomization failed");
    end
    
    for (int i = 0; i<5; i++) begin
      check = pkt.randomize() with {a<10;};
      if(check == 1)
        $display(" Value of a = %0d",pkt.a);//Display 5<a<10
      else
        $display("Randomization failed");
    end
    
    for (int i = 0; i<5; i++) begin
      check = pkt.randomize() with {a==4;};
      if(check == 1)
      $display(" Value of a = %0d",pkt.a);
      else
        $display("Randomization failed");//it will display
    end
  end
endmodule

//OUTPUT
# KERNEL: ----------------Without soft-------------------
# KERNEL:  Value of a = 10
# KERNEL:  Value of a = 6
# KERNEL:  Value of a = 7
# KERNEL:  Value of a = 8
# KERNEL:  Value of a = 11
# KERNEL:  Value of a = 8
# KERNEL:  Value of a = 6
# KERNEL:  Value of a = 6
# KERNEL:  Value of a = 7
# KERNEL:  Value of a = 7
# RCKERNEL: Warning: RC_0024 testbench.sv(31): Randomization failed. The condition of randomize call cannot be satisfied.
# RCKERNEL: Info: RC_0109 testbench.sv(31): ... after reduction pkt.a to 4
# RCKERNEL: Info: RC_0103 testbench.sv(31): ... the following condition cannot be met: (5<4'(4))
# RCKERNEL: Info: RC_1007 testbench.sv(2): ... see class 'packet' declaration.
# KERNEL: Randomization failed
# KERNEL: Randomization failed
# KERNEL: Randomization failed
# KERNEL: Randomization failed
# KERNEL: Randomization failed

  
