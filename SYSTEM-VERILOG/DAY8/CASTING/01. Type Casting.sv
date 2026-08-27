//Type Casting
module casting_example;
  string name;
  int num[3];//1-D Unpacked Array
  real r_num;
  initial begin
    name = "D";
    r_num = 2.8;
    
    num[0] = int'(name); //Takes ascii value for string
    num[1] = int'(r_num); // Real to Int
    
    r_num = 2.125 + real'({4'h1, 4'hA});  
    num[2] = int'((num[0] == 68)?r_num: 4.7); 
    
    $display("string to int: num[0] = %0d", num[0]);
    $display("real to int: num[1] = %0d", num[1]);
    $display("int to real: r_num = %0f", r_num);
    $display("expression from real to int: num[2] = %0d", num[2]);
    $display("num = %p", num);
  end
endmodule
