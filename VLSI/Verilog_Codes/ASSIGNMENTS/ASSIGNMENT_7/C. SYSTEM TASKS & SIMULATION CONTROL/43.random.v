module random;
  reg [7:0] data;

  integer i;

  initial begin
    for(i=0; i<5; i=i+1) begin
      data = $random % 256;  
      $display("Random value[%0d] = %d", i, data);
      #5;
    end
    $finish;
  end
endmodule

