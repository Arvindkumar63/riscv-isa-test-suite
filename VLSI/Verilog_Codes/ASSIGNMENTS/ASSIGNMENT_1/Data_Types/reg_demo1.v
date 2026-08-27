module reg_demo;
  reg a;


  initial begin
    $monitor(" Time= %t , Reg= %b ", $time, a);
    a=1'b0; #10;
    a=1'b1; #10;
   
  end
endmodule
