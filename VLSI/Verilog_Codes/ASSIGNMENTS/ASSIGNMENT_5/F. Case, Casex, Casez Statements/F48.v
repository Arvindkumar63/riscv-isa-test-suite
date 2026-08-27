module case_compare_tb;
  reg [2:0] sel;
  reg [7:0] out_case, out_casex, out_casez;

  always @(*) begin
    case(sel)
      3'b100: out_case = 8'b00001111;
      3'b101: out_case = 8'b11110000;
      default: out_case = 8'b11111111;
    endcase
  end

  always @(*) begin
    casex(sel)
      3'b1x0: out_casex = 8'b10101010; // take x,z,? as don't care 
      3'b101: out_casex = 8'b01010101;
      default: out_casex = 8'b11111111;
    endcase
  end

  always @(*) begin
    casez(sel)
      3'b1?0: out_casez = 8'b11111100; // ? z as don't-care
      3'b101: out_casez = 8'b00111100;
      default: out_casez = 8'b11111111;
    endcase
  end

  initial begin
    $dumpfile("case_compare.vcd");
    $dumpvars(0,case_compare_tb);
    $monitor("T=%0t | sel=%b | case=%b casex=%b casez=%b",$time,sel,out_case,out_casex,out_casez);

    sel=3'b100; #5;
    sel=3'b101; #5;
    sel=3'b1x0; #5;  // will show difference
    sel=3'b1z0; #5;  // will show difference
    $finish;
  end
endmodule

