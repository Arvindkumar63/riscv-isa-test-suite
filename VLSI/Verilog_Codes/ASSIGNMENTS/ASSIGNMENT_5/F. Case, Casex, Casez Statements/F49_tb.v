module bus_decoder_tb;
  reg [2:0] addr;
  wire [7:0] out;

  bus_decoder uut(.addr(addr), .out(out));

  initial begin
    $dumpfile("bus_decoder.vcd");
    $dumpvars(0, bus_decoder_tb);
    $monitor("T=%0t | addr=%b out=%b", $time, addr, out);

    addr=3'b000; #5;
    addr=3'b001; #5;
    addr=3'b010; #5;
    addr=3'b011; #5;
    addr=3'b100; #5;
    addr=3'b101; #5;
    addr=3'b110; #5;
    addr=3'b111; #5;
    addr=3'bxxx; #5; // invalid
    #5 $finish;
  end
endmodule

