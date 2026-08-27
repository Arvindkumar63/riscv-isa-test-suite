module sign_int;
  integer i; //default:signed and 32 bits

  initial begin
    $monitor("TIME=%0t , Signed_Value= %b", $time,i);
    i= 250; #10;    //default decimal
    i= -250; #10;    //default decimal
    $finish;
  end
endmodule
