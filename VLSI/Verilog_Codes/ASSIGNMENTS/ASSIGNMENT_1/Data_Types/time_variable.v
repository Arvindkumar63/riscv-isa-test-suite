module time_variable;
  time t;
  
  initial begin 
    $monitor("TIME = %0t", t);
    t=$time; #10;
    t=$time; #10;
    $finish;
  end

endmodule
