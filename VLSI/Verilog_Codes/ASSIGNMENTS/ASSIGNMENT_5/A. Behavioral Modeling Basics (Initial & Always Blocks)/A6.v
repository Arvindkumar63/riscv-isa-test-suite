module setup_func;
  reg [15:0]data;

  // setup
  initial begin
    $monitor("%0t %b",$time,data);
    data = 1;
    #100;
    $finish;
  end

  // functional
  always #5 data = data*2;

endmodule

