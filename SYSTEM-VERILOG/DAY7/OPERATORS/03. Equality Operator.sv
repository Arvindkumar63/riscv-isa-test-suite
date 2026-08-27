// Equality Operators
module equality_op;
  logic [15:0]i1,i2;
  
  initial begin
    i1='hff; i2='h0f;
    $display("-----Logical equality-----");// if x or z is input , gives output as x
    $display("i1='hff i2='h0f :i1 == i2 =boolean %0d",i1==i2);
    $display("i1='hff i2='h0f :i1 != i2 =boolean %0d",i1!=i2);
    $display("-----case equality------"); // Look Exact match
    $display("i1='hff i2='h0f :i1 === i2 =boolean %0d",i1===i2);
    $display("i1='hff i2='h0f :i1 !== i2 =boolean %0d",i1!==i2); 
    
   
   i1='hxf; i2='hxf;

    $display("------Logical equality------");
    $display("i1='hxf i2='hxf :i1 == i2 =boolean %0d",i1==i2);
    $display("i1='hxf i2='hxf :i1 != i2 =boolean %0d",i1!=i2);
    $display("------case equality------");
    $display("i1='hxf i2='hxf :i1 === i2 =boolean %0d",i1===i2);
    $display("i1='hxf i2='hxf :i1 !== i2 =boolean %0d",i1!==i2); 

      
   i1='hxzf; i2='hzxf;

    $display("------Logical equality------");
    $display("i1='hxzf i2='hzxf :i1 == i2 =boolean %0d",i1==i2);
    $display("i1='hxzf i2='hzxf :i1 != i2 =boolean %0d",i1!=i2);
    $display("------case equality------");
    $display("i1='hxzf i2='hzxf :i1 === i2 =boolean %0d",i1===i2);
    $display("i1='hxzf i2='hzxf :i1 !== i2 =boolean %0d",i1!==i2);
    
    i1='h5f; i2='h5x;

    $display("------Wildcard equality------");// if lhs = x -> output =x if rhs = x ->treat it as dont care
    $display("i1='h5f i2='h5x :i1 ==? i2 =boolean %0b",i1==?i2);
    $display("i1='h5f i2='h5x :i1 !=? i2 =boolean %0b",i1!=?i2);

      i1='hxx; i2='hff;

    $display("------Wildcard equality------");
    $display("i1='hxx i2='hff :i1 ==? i2 =boolean %0b",i1==?i2);
    $display("i1='hxx i2='hff :i1 !=? i2 =boolean %0b",i1!=?i2);
    
    
  end
endmodule
