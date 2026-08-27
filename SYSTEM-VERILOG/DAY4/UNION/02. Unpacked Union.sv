//Unpacked Union
module union_unpacked;
  bit[31:0] x;
  typedef union {
    int a;
    logic[15:0] b; // all members are in different size
  } data;
  data d1;
  
  initial begin
    d1.a = 32'h0f0f0f0f0f;//write to a
    x = d1.b;//read to b  // only read from b
    $display("x=%h",x); // Exp Output: 00000f0f
    
    d1.b = 16'h0001;//write to b
    x = d1.a;//read to a//Expected Output: 00000001 (ffffffff is totally cleared)
    $display("x=%h",x);
  end
endmodule
