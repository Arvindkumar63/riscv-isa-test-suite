// Write a constraint to ensure unique elements in a 2D array without using the unique keyword.
class packet;
  rand bit[3:0] array[4][4];

  constraint unique_elements { foreach (array[i,j]) {
    foreach (array[a,b]){
      if(!(a==i && b==j)) 
        array[a][b] != array [i][j];
    }
  }}
                
endclass



module test;
  packet p;
  
  initial begin
    p=new();
    p.randomize;
    $display("Array = %0p", p.array);
  end
endmodule

    //OUTPUT
    Array = {6 7 8 1} {11 9 2 12} {0 13 3 15} {5 10 4 14}
