// 2D static array randomization
class static_array_2D;  
  rand byte a[2][4];  
endclass  

module mod;  
  static_array_2D pack;  
  initial begin  
    pack = new;  
    for (int i = 0; i <= 5; i++) begin  
      void'(pack.randomize());  
      $display("The value of elements of array after randomization = %0p", pack.a); 
  end 
  end
endmodule

//OUTPUT
The value of elements of array after randomization = '{'{'hf6, 'hcf, 'h63, 'h60}, '{'hf5, 'h7, 'hc7, 'h6}}
The value of elements of array after randomization = '{'{'h1e, 'h5d, 'h97, 'h81}, '{'hd9, 'h29, 'h6, 'hd6}}
The value of elements of array after randomization = '{'{'hb4, 'hbf, 'h11, 'h62}, '{'h83, 'hdf, 'heb, 'hf0}}
The value of elements of array after randomization = '{'{'hc3, 'h92, 'hfc, 'hb7}, '{'h4b, 'h15, 'hcd, 'h1d}}
The value of elements of array after randomization = '{'{'hf3, 'hec, 'hec, 'h95}, '{'h87, 'hc2, 'h70, 'h99}}
The value of elements of array after randomization = '{'{'hf1, 'h79, 'haa, 'he8}, '{'hf4, 'h91, 'h80, 'h8b}}
