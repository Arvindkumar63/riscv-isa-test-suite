module mux4to1;
  reg [3:0] A, B, C, D;
  reg [1:0] sel;
  wire [3:0] Y;

  function [3:0] mux4to1;
    input [3:0] a, b, c, d;
    input [1:0] s;
    begin
      case(s)
        2'b00: mux4to1 = a;
        2'b01: mux4to1 = b;
        2'b10: mux4to1 = c;
        2'b11: mux4to1 = d;
      endcase
    end
  endfunction

  assign Y = mux4to1(A, B, C, D, sel);

  initial begin
    $monitor("TIME=%0t | sel=%b | Y=%d",$time,sel,Y);
    A=4'd1; B=4'd2; C=4'd3; D=4'd4;
    sel=2'b00; #10;
    sel=2'b01; #10;
    sel=2'b10; #10;
    sel=2'b11; #10;
    $finish;
  end
endmodule

