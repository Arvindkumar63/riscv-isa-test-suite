module wire_demo1;
  wire w;

  assign w= 1'b1; 
  

  initial begin
    $display(" WIRE= %b ", w);
  end

endmodule
