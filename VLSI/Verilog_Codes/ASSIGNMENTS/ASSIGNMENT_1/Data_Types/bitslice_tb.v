module bitslice_tb;
  reg [7:0] data;
  wire [3:0] upper,lower;
  wire [3:0] sum;

  bitslice uut(data,upper,lower,sum);  

  initial begin
    $dumpfile("bitslice.vcd");
    $dumpvars(0, bitslice_tb);
    $monitor("TIME = %4t, data =%b, upper = %b, lower = %b, sum= %b",$time,data,upper,lower,sum);

    data = 8'b10110011; #10;  // upper=1011=11, lower=0011=3, sum=1110=14
    data = 8'b01011100; #10;
    $finish;
  end
endmodule

