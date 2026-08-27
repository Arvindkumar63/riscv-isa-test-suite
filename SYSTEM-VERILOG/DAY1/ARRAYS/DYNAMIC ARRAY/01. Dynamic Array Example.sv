// DYNAMIC ARRAY
module dynamic_array;
  int array[];
  initial begin
    array = new[5];
    array = '{1,2,3,4,5};
    $display("size of array = %0d",array.size( ));
    foreach (array[i])begin
      $display("array[%0d] = %0d",i,array[i]);
    end
    
    array = new[6](array);//Resizing of an array and copy old array content
    $display("size of array = %0d",array.size( ));
    foreach (array[i])begin
      $display("array[%0d] = %0d",i,array[i]);
    end
    
    array = new[8];//Override existing array: Previous array elememt values will be lost
    $display("size of array = %0d",array.size( ));
    foreach (array[i])begin
      $display("array[%0d] = %0d",i,array[i]);
    end
    
    array.delete();
    $display("size of array after deleting = %0d",array.size( ));
  end
endmodule
