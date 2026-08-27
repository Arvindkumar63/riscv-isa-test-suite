module compare;
  reg [7:0]A,B;
  wire is_equal;

  function compare_fn(input [7:0]A,B);
  begin
      if(A==B) begin
       compare_fn=1;
       $display("Equal");
       end
      else begin
       compare_fn=0; 
       $display("Not Equal");
       end
  end
  endfunction
  assign is_equal = compare_fn(A,B);

  initial begin
    $monitor("TIME=%0t | A=%d | B=%d | Equal=%b",$time,A,B,is_equal);
    A=8'd20; B=8'd20; #10;
    A=8'd10; B=8'd20; #10;
    A=8'd30; B=8'd25; #10;
    A=8'd25; B=8'd25; #10;
    A=8'd10; B=8'd10; #10;
    A=8'd24; B=8'd24; #10;
    $finish;
  end
endmodule
