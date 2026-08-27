// String Methods
module str_methods;
   string str = "Unique Element";
   int i;
   real r;

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
     
     
     
     //string conversion Methods
     str = "1234abcdl56";
     //atoi: return integer corresponding to ASCII decimal representation
      i = str.atoi();
     $display("str.atoi() = %0d", i);
     $display("str.atoi() = %0d", str.atoi());
     //atohex: Interprets String as hexa
     i = str.atohex();
     $display("str.atohex() = %0h(%0d)", i, i);
     $display("str.atohex() = %0h(%0d)", str.atohex(), str.atohex());
     //atooct: Interprets String as octal
     i = str.atooct();
     $display("str.atooct() = %0o(%0d)", i, i);
     $display("str.atooct() = %0o(%0d)", str.atooct(), str.atooct());
     //atobin: Interprets String as binary
     i = str.atobin();
     $display("str.atobin() = %0b(%0d)", i, i);
     $display("str.atobin() = %0b(%0d)", str.atobin(), str.atobin());
     //atoreal: Return the Real Number
     i = str.atoreal();
     $display("str.atoreal() = %0f(%0d)", i, i);
     $display("str.atoreal() = %0f(%0d)", str.atoreal(), str.atoreal());
     
     i = 123456;
     //itoa: store ASCII decimal representation of i into str
     str.itoa(i);
     $display("str.itoa() = %s", str);
     //hextoa: store ASCII hexadecimal representation of i into str
     str.hextoa(i);
     $display("str.hextoa() = %s", str);
     //octtoa: store ASCII octal representation of i into str
     str.octtoa(i);
     $display("str.octtoa() = %s", str);
     //bintoa: store ASCII binary representation of i into str
     str.bintoa(i);
     $display("str.bintoa() = %s", str);
     //realtoa: store ASCII real representation of i into str
     r=13.25;
     str.realtoa(r);
     $display("str.realtoa() = %s", str);
     
   end
endmodule
