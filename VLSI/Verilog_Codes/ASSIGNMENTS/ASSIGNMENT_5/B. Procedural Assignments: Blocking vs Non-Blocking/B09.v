module blocking_demo;
  reg [3:0] a,b;

  initial begin
    a = 4'b0001;     // executes first
    b = a;           // uses updated value
    $display("Blocking: a=%b b=%b", a, b);
  end
endmodule

