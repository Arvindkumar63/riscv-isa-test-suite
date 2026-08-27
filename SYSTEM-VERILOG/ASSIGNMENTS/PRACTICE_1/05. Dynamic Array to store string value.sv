// Dynamic Array to store string value
module dynamic_string;
  string arr[];//Dynamic array to store String value
  initial begin
    $display("size of arr is",arr.size());
    arr = new[5];//size must be allocted as 5
    arr = {"melody", "karnatic", "classical", "bgm", "music"};
    $display("size of arr is",arr.size());
    $display("%0p",arr);
    arr = new[15](arr);//resize array as 15 and copy previous 5 values
    $display("size of arr is",arr.size());
    $display("%0p",arr);
    arr.delete();//
    $display("size of arr is",arr.size());
  end
endmodule
