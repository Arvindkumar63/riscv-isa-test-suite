//Tagged Union
module tagged_union;
  bit[31:0] x;
  typedef union tagged {
    int a;
    logic[31:0] b;
    bit [31:0] c;
  } data;
  data d1;
  
  initial begin
    d1 = tagged a 32'hffff_ffff;//write to a
    x = d1.a;//read to b
    $display("x=%h",x);
    
    d1 = tagged b 32'h0000_ffff;//write to a
    x = d1.b;//read to b
    //x = d1.a; // Error: Union is tagged 'b', but is referenced as 'a'
    $display("x=%h",x);
  end
endmodule
