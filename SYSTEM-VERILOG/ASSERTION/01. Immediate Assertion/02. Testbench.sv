// Code your testbench here
// or browse Examples
module tb;
  reg a, b, clk; 
  wire y;
  logic assert_pass;
  
  and_log uut ( .a(a), .b(b), .y(y) );
  
  always #5 clk = ~clk;
  
  initial begin
    clk = 0;
    a = 0;
    b = 0;
    
    #10;
    a = 0;
    b = 1;
    
    #10;
    a = 1;
    b = 0;
    
    #10;
    a = 1;
    b = 1;
    
    #10;
    a = 1;
    b = 1'bx;
    
    #20;
    $finish;
  end
  
  
  always @(posedge clk) begin 
    assert (a==0 && b==0) begin
      $info("%0t, A=0 and B=0, assertion failed",$time);
      assert_pass = 0;
    end
    else assert (a==0 && b==1) begin
      $info("%0t, A=0 and B=1, assertion failed",$time);
      assert_pass = 0;
    end
    else assert (a==1 && b==0) begin
      $info("%0t, A=1 and B=0, assertion failed",$time);
      assert_pass = 0;
    end
    else assert (a==1 && b==1) begin
      $display("%0t, A=1 and B=1,assertion Success",$time);
      assert_pass = 1;
    end
    else begin
      $error("%0t fail",$time);
      assert_pass = 1'bx;
    end
  end
  
  initial begin
    $dumpfile("waveform.vcd");
    $dumpvars();
  end
  
endmodule 
    
