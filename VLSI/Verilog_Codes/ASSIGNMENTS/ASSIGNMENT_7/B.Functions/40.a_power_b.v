module power;
  reg [2:0] a;
  reg [2:0] b;
  wire [20:0] result;

  function integer power;
    input integer base, exp;
    integer i;
    begin
      power = 1;
      for (i=0; i<exp; i=i+1)
        power = power * base;
    end
  endfunction

  assign result = power(a, b);

  initial begin
    $monitor("TIME=%0t | a=%d | b=%d | result=%d",$time,a,b,result);
    a=2; b=3; #10;
    a=5; b=4; #10;
    a=3; b=0; #10;
    a=7; b=7; #10;
    $finish;
  end
endmodule

