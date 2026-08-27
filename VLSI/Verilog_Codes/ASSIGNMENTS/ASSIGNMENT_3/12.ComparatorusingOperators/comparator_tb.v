module comparator_tb;
  reg [3:0]a,b;
  wire eq,lt,gt;

  comparator uut(a,b,eq,lt,gt);

  initial begin
    $monitor("TIME= %t | A =%b | B = %b | EQ = %b | LT = %b | GT = %b", $time,a,b,eq,lt,gt);

    a=4'b1011; b=4'b1101; #10;
    a=4'b1111; b=4'b0101; #10;
    a=4'b1011; b=4'b1111; #10;
    a=4'b1011; b=4'b1011; #10;
    a=4'b1000; b=4'b1101; #10;
    a=4'b0001; b=4'b1101; #10;
    a=4'b1011; b=4'b0110; #10;
    a=4'b1011; b=4'b0000; #10;
    $finish;
    end
endmodule
