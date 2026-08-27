module nonblocking_demo;
  reg [3:0] a,b;

  initial begin
    a <= 4'b0001;    // schedules update
    b <= a;          // uses OLD value
    #5 $display("Non-Blocking: a=%b b=%b", a, b);
  end
endmodule

