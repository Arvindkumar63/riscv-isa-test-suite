module reg_assign;
  reg [7:0]data;
  
  initial begin 
    $monitor("TIME=%0t , DATA= %b", $time,data);
    data=23; #10;    //default decimal
    data=15; #10;    //default decimal
    $finish;
  end
endmodule
