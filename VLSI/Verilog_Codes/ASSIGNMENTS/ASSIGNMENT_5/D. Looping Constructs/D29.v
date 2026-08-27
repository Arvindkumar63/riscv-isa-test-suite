module mem_init;
  reg [7:0] mem [15:0];
  integer i;

  initial begin
    i = 0;
    repeat (16) begin
      mem[i] = i; 
      $display ( "mem[%0d] = %0b" , i,mem[i]);
      i = i + 1;
    end
  end
endmodule

