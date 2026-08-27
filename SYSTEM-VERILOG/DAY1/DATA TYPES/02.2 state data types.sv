// 2 state DATA TYPES 
module data_type_2;
  bit [7:0] a = -1; //8 bit unsigned
  byte b = -1; //8 bit
  shortint s = 300; //16 bit
  int i = 32'hfxfz_ffxz; //32 bit
  longint l = 64'hffffzzzzzzzzffff;  //64 bit

  initial begin
    $display("bit = %0d", a);
    $display("byte = %0d", b);
    $display("shortint = %0d", s);
    $display("int = %0h", i);
    $display("longint = %0h", l);
    #10 $finish;
  end
endmodule
