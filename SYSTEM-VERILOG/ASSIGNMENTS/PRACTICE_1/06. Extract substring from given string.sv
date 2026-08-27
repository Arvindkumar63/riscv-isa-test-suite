// Extract substring from given string
module sub_str;
  string str ="Hello World";
  string sub_str;
  initial begin
    sub_str = str.substr(0,4);
    $display("Extracted Substring : %s", sub_str);
  end
endmodule
