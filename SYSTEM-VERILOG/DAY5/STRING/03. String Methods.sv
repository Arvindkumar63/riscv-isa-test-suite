// String Methods
module str_methods;
   string str = "Unique Element";

   initial begin
   	  string tmp;

	  // Print length of string
      $display ("str.len() = %0d", str.len());

      // Assign to tmp variable and put char "d" at index 3
      tmp = str;
      tmp.putc (3,"d");
      $display ("str.putc(3, d) = %s", tmp);

      // Get the character at index 2
      $display ("str.getc(2) = %s (%0d)", str.getc(2), str.getc(2));

      // Convert all characters to lower case
      $display ("str.tolower() = %s", str.tolower());
     
     // Convert all characters to upper case
     $display ("str.toupper() = %s", str.toupper());

      // Comparison
      tmp = "Unique Element";
      $display ("[tmp,str are same] str.compare(tmp) = %0d", str.compare(tmp));
      tmp = "unique element";
      $display ("[tmp,str are diff] str.compare(tmp) = %0d", str.compare(tmp));

      // Ignore case comparison
      tmp = "unique element";
     $display ("[tmp is in lowercase] str.icompare(tmp) = %0d", str.icompare(tmp));
      tmp = "Unique Element";
     $display ("[tmp,str are same] str.icompare(tmp) = %0d", str.icompare(tmp));

      // Extract new string from i to j
      $display ("str.substr(4,8) = %s", str.substr (4,8));

   end
endmodule
