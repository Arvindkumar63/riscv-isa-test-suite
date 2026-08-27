module armstrong_tb;
  reg [9:0]num;
  wire isarm;

  armstrong uut(.num(num), .isarm(isarm));

  initial begin
    $monitor("NUM = %d  isarm = %b" ,num,isarm);
    num = 153; #10;
    num = 155; #10;
    num = 371; #10;
    num = 143; #10;
    num = 407; #10;
    $finish;
  end

  always @(isarm) begin
	if(isarm == 1)
	      $display("%d is armstrong number",num);
        else
	      $display("%d is not armstrong number", num);
  end

  endmodule  
