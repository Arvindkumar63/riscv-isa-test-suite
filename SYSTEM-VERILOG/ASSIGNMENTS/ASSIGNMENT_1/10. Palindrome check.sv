// 10. Palindrome check
module palindrome_check;
  string s;
  string rev_s;
  function void palindrome;
    rev_s="";
    for (int i = (s.len())-1; i>=0; i--) begin
      rev_s = {rev_s,s[i]};
    end
    if(s == rev_s) 
      $display("Given string is palindrome");
    else
      $display("Given string is not a palindrome");
  endfunction
  initial begin
    s = "DEEPA";
    palindrome();
    s = "MADAM";
    palindrome();
  end
endmodule
