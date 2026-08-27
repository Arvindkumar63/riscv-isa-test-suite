// String Example
module string_datatype;
  string s1 = "HELLO";
  string s2 = "Hello world";
  string s3 = "Hello\0world"; // \0 is ignored
  string s4,s5,s6;
  
  initial begin
    s4 = "later";
    s5 = ""; // Empty string
    s6 = {"Hi",s1}; // Concatenation
    foreach (s1[i]) begin
      $display("S1[%0d] = %s", i,s1[i]);
    end
    $display("s1 = %s   s2 = %s   s3 = %s   s4 = %s   s5 = %s   s6 = %s",s1,s2,s3,s4,s5,s6);
  end
endmodule
