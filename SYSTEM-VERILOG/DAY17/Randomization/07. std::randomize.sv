//std :: randomize in module
module std_random_module;
  bit [3:0]a;
  bit [3:0]b;
  bit [3:0]c;
  bit [3:0]d;
  bit [3:0]e;
  
  initial begin    
    repeat(4)
      begin
        void'(std::randomize(a));
        $display("value of a %0d",a);
        void'(std::randomize(b) with {b>6; a<12;});
        $display("value of b:%0d",b);
        void'(std::randomize(c,d) with {c<4; d<3;});
        $display("value of c:%0d and d:%0d",c,d);
        void'(std::randomize(e) with {e inside {[1:4]};});
        $display("value of e:%0d",e);
      end
  end
endmodule

//OUTPUT
# KERNEL: value of a 4
# KERNEL: value of b:12
# KERNEL: value of c:2 and d:0
# KERNEL: value of e:3
# KERNEL: value of a 6
# KERNEL: value of b:15
# KERNEL: value of c:1 and d:2
# KERNEL: value of e:3
# KERNEL: value of a 9
# KERNEL: value of b:10
# KERNEL: value of c:0 and d:1
# KERNEL: value of e:1
# KERNEL: value of a 1
# KERNEL: value of b:15
# KERNEL: value of c:0 and d:1
# KERNEL: value of e:2
