// String Operators
module str_operators;
  string firstname = "DEEPA";
  string lastname = "Shruthi";
  initial begin
    //String Equality
    if (firstname == lastname)
      $display ("firstname=%s equals lastname=%s", firstname, lastname);
    if (firstname != lastname)
      $display ("firstname=%s not equals lastname=%s", firstname, lastname);
    
    //String Comparison:Compare the length
    if (firstname < lastname)
      $display ("firstname=%s is LESS THAN lastname=%s", firstname, lastname);
    if (firstname > lastname)
      $display ("firstname=%s is LESS THAN lastname=%s", firstname, lastname);

    
    // String concatenation : Join first and last names into a single string
    $display ("Full Name = %s", {firstname, " ", lastname});

    // String Replication
    $display ("%s", {3{firstname}});

    // String Indexing : Get the ASCII character at index number 2 of both first and last names
    $display ("firstname[2]=%s lastname[2]=%s", firstname[2], lastname[2]);
    
  end
endmodule
