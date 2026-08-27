module loop_wave;
  reg a, b, c;
  integer i;

  // for loop toggles 5 times
  initial begin
    a = 0;
    for (i = 0; i < 5; i = i + 1) begin
      #5 a = ~a;
    end
  end

  // repeat loop toggles 10 times
  initial begin
    b = 0;
    repeat (10) begin
      #5 b = ~b;
    end
  end

  // forever loop toggles until simulation ends
  initial begin
    c = 0;
    forever #5 c = ~c;
  end

  // dump to waveform
  initial begin
    $monitor("TIME=%3t a=%b b=%b c=%b",$time,a,b,c);
    $dumpfile("loop_wave.vcd");
    $dumpvars(0, loop_wave);
    #200 $finish;   // stop simulation after 200 time units
  end
endmodule
