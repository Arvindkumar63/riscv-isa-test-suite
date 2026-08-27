//Packed Union
module union_packed;
  bit[31:0] x;
  typedef union packed{
    int a;
    logic[31:0] b;       // all members are in same bit width
    bit [31:0] c;
  } data;
  data d1;
  
  initial begin
    d1.a = 32'hffff_ffff;//write to a
    x = d1.b;//read to b
    $display("x=%h",x);
    
    d1.b[31:16] = 16'h0000;//write to b //Only 31:16 bit is changed
    x = d1.c;//read to c
    $display("x=%h",x);  //Expected Output: 0000ffff
  end
endmodule
