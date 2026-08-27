module diff_num;
  reg [7:0] A, B;
  wire signed [8:0] Diff; 
 
  function signed [8:0] diff(input signed [7:0] x, input signed [7:0] y);
    begin
      diff = x - y;
    end
  endfunction

  assign Diff = diff(A,B);

  initial begin
    $monitor("Time=%0t | A=%0d | B=%0d | Diff=%0d", $time, A, B, Diff);

    A = 20; B = 10;  #10;  
    A = 10; B = 20;  #10;  
    A = 50; B = 25;  #10; 
    A = 10;  B = 30; #10;  

    #50 $finish;
  end
endmodule

