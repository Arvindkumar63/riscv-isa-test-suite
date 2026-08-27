module power_of_2;
  reg [31:0]A;
  wire power2;

  function is_power_of_two(input [31:0] A);
    integer i, count;
    begin
      count = 0;
      for (i = 0; i < 32; i = i + 1) begin
        if (A[i] == 1'b1)
          count = count+1;
      end
      if (A > 0 && count == 1 ) begin 
        is_power_of_two = 1'b1;
	$display("Power of 2");
      end
      else begin
        is_power_of_two = 1'b0; 
	$display("Not a Power of 2");
      end
    end
  endfunction

  assign power2 = is_power_of_two(A);
  initial begin
    $monitor("TIME=%0t | A=%d | power2=%b",$time,A,power2);
    A=32'd1024; #10;
    A=32'd25; #10;
    A=32'd256; #10;
    A=32'd32; #10;
    A=32'd4096; #10; 
    $finish;  
  end

endmodule

