module buffer_store;
  reg clk;
  reg [7:0]data_in;
  reg [7:0] buff [0:7];
  integer i;

  initial begin
    clk = 0;  
    forever #5 clk = ~clk;
  end

  initial begin
    i = 0;
    repeat (8) begin
      @(posedge clk);
      data_in = i*5;
      buff[i] = data_in ;
      $display("Time=%0t Stored buf[%0d]=%d", $time, i, buff[i]);
      i = i + 1;
    end
    $finish;
  end

endmodule

