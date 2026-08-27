module flag_logic_tb;
  reg f1,f2,f3;
  wire out;

  flag_logic uut(.f1(f1), .f2(f2), .f3(f3), .out(out));

  initial begin 
    $dumpfile("flag_logic.vcd");
    $dumpvars;
    $monitor("TIME=%0t | f1=%b f2=%b f3=%b | out=%b" , $time,f1,f2,f3,out);

    f1=0; f2=0; f3=0;  #10;
    f1=1; f2=0; f3=0;  #10;
    f1=1; f2=1; f3=0;  #10;
    f1=0; f2=1; f3=1;  #10;
    f1=1; f2=0; f3=1;  #10;
    $finish;
  end
endmodule
