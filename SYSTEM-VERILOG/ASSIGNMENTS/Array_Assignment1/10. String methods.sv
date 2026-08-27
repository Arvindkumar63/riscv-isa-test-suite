// 10. Write a test bench to test string data type and its predefined methods by using the following statements
// a. declare a string data type and assign it to“SystemVerilog”
// b. use the getc() method to display the ASCII value of the first character of this string
// c. use toupper() method to display the string in capital letter
// d. concatenate the string with string “3.1a” and display
// e. replace the last character in the string with character ‘b’ using len() method and display
// f. use substr() method to display substring from 2nd to 5th character

module string_methods;
  string s1 ="SystemVerilog";
  string s2,s3;
  int x,n;
  initial begin
    x = s1.getc(0);
    $display("ASCII value of the first character of this string:%0d",x);
    s2 = s1.toupper();
    $display("string in capital letter:%0s",s2);
    s3={"3.1a",s1};
    $display("conc:%0s",s3);
    n=s1.len();
    s1[n-1]="b";
    $display("last character in the string with character b:%0s",s1);
    $display("Substring from 2 to 5:%0s",s1.substr(2,5));
  end
endmodule
