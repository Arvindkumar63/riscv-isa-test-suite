// 09. Reverse the string
module rev_str;
  string s;
  string rev_s;
  initial begin
    s = "DEEPASHRUTHI";
    //rev_s ="";
    for (int i = (s.len())-1; i>=0; i--) begin
      rev_s = {rev_s,s[i]};
    end
    $display("STRING = %0s   REVERSE_STRING = %0s", s,rev_s);
    $finish;
  end
endmodule
