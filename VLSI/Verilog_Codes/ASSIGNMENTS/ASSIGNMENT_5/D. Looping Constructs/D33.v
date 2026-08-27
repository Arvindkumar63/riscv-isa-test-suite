module parity_check;
  reg [7:0] data;
  reg parity;
  integer i;

  initial begin
    parity = 0; data = 8'b10110110;
    for (i=0; i<8; i=i+1)
      parity = parity^data[i];
    $display("Data=%b Parity=%b", data, parity);
  end
endmodule

