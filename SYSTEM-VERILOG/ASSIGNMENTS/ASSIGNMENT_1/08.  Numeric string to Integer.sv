// 08. Numeric string to Integer 
module str_int;
  string s;
  int i;
  initial begin
    s = "12345cc45";
    i = s.atoi();
    $display("string to integer" , i);
    i = i+100;
    $display("i+100",i);
    i = i-445;
    $display("i-445",i);
    i = i*2;
    $display("i*2",i);
  end
endmodule
