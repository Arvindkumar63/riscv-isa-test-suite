module dump_file_vars;
  reg [3:0]a;
  wire [3:0]b;
  
  assign b=~a;

  initial begin 
    $dumpfile("dump_file_vars.vcd");
    $dumpvars(0,dump_file_vars);
    $monitor("TIME=%0t A=%b Y=%b",$time,a,b);
    a=4'b0010; #5;
    a=4'b0000; #5;
    a=4'b1111; #5;
    a=4'b1010; #5;
    $finish;
  end
endmodule

    
