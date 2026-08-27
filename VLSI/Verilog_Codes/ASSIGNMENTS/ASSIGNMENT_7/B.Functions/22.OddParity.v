module odd_parity;
  reg [7:0] data;
  wire parity;

  function parity_fn(input [7:0] d);
    integer i;
    begin
    parity_fn = 0;
    for (i = 0; i < 8; i = i + 1) 
    begin
        parity_fn = parity_fn ^ d[i];
    end
    end
  endfunction
  assign parity = ~ parity_fn(data);
  
  initial begin
    $monitor("Time=%0t | data=%b | parity=%b", $time, data, parity);

    data = 8'b00000000;  #10;
    data = 8'b00010011;  #10;
    data = 8'b10101010;  #10;
    data = 8'b11110010;  #10;
    data = 8'b11111101;  #10;

    #50 $finish;
  end
endmodule

