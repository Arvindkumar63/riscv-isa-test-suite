// Example for 2 state and 4 state and their assignments
module data_type_1;
  bit  [3:0] a;        // 2-state
  logic [3:0] b;        // 4-state

  initial begin
    a = 4'b101x;  
    $display("bit a = %b", a);
    b = 4'b1xxx;     
    $display("logic b = %b", b);
    a = b;   //Take x as 0 when assigning 4 state variable to 2 state variable
    $display("bit a = %b", a);
    #10 $finish;
  end
endmodule
