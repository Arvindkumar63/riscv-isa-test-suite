module bitwise_tb;
    reg [3:0] x,y;
    wire [3:0] notx, andxy, orxy, xorxy, xnorxy;

    bitwise uut (.x(x), .y(y), .notx(notx), .andxy(andxy), .orxy(orxy), .xorxy(xorxy), .xnorxy(xnorxy));

    initial begin
      $display ( "TIME |   X  |  Y  |  NOT | AND | OR | XOR | XNOR  ");
      $monitor ("%4t  %b  %b  %b  %b  %b  %b  %b ", $time, x, y, notx, andxy, orxy, xorxy, xnorxy);
      x=4'b1010; y=4'b1100; #10;
      x=4'b1111; y=4'b0000; #10;
      x=4'b0101; y=4'b0011; #10;
      x=4'b1x11; y=4'b110x; #10;
      x=4'b1010; y=4'bz100; #10;
      x=4'b1111; y=4'bz000; #10;                                                                                                                                  x=4'b01z1; y=4'b0011; #10;                                                                                                                                  $finish;    
    end
endmodule

