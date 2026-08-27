// Packed Structure
module packed_struct;
  struct packed{
    bit [7:0] intr;
    logic [23:0] addr;
  }STRU;
  initial begin
    STRU.intr = 'hff;
    $display ("STRU = %h", STRU);
    $display ("STRU INTR = %h", STRU.intr);
    
    STRU = 32'h 00_FFFFFF;
    $display ("STRU = %h", STRU);
    
    STRU = '{'h12,'h123456};
    $display ("STRU = %h", STRU);
    
    
    STRU = 0;
    STRU = STRU + 'h123;
    $display ("STRU = %h", STRU);
  end
endmodule
