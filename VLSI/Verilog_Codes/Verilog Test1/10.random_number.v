module random_num;
  reg signed[7:0] num;
  integer i;

  initial begin
    for (i=1; i<20; i++) begin
    num = $random %100;
    $display(num);
    end
    #10 $finish;
  end
endmodule
