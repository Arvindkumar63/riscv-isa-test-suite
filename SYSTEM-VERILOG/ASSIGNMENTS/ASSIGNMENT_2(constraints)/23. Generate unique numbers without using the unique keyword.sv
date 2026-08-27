// Write a constraint to generate unique numbers without using the unique keyword.
class unique_gen;
  rand bit [7:0] data[5];  
  constraint c1 {
    foreach (data[i])
      foreach (data[j])
        if (i != j)
          data[i] != data[j];   
  }
endclass

module uniq_num;
  unique_gen ug;
  initial begin
    ug = new();
    ug.randomize();
    $display("Data = %0p", ug.data);
  end
endmodule

//OUTPUT
Data = 176 68 145 111 222
