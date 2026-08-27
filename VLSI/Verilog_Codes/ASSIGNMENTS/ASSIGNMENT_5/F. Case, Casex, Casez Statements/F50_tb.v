module casex_problem_tb;
  reg [3:0] sel;
  wire [7:0] out;

  casex_problem uut(.sel(sel), .out(out));

  initial begin
    $dumpfile("casex_problem.vcd");
    $dumpvars(0, casex_problem_tb);
    $monitor("T=%0t | sel=%b out=%b", $time, sel, out);

    sel=4'b1000; #5; // Matches 1xxx 
    sel=4'b01x1; #5; // X inside input → still matches 01xx
    sel=4'b001z; #5; // Z treated as don't-care → matches 001x
    sel=4'b0001; #5; 
    $finish;
  end
endmodule

