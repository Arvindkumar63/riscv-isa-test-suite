module alu_tb;
  reg  [3:0]a,b;
  reg  [2:0]sel;
  wire [3:0]result;
  wire carry;

  simple_alu uut (.a(a),.b(b),.sel(sel),.result(result),.carry(carry));

  initial begin
    $monitor("Time=%0t | sel=%b | a=%b b=%b | y=%b carry=%b",$time,sel,a,b,result,carry);

    a=4'b0101; b=4'b0011; 
    
    sel=3'b000; #10;   // ADD
    sel=3'b001; #10;   // SUB
    sel=3'b010; #10;   // AND
    sel=3'b011; #10;   // OR
    sel=3'b100; #10;   // XOR
    sel=3'b101; #10;   // XNOR
    sel=3'b110; #10;   // Divide
    sel=3'b111; #10;   // Modulus

    $finish;
  end
endmodule

