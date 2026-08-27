// UnPacked Structure
module unpacked_struct;
  struct {
    bit [7:0] intr;
    logic [23:0] addr;
  }STRU;
  initial begin
    STRU.intr = 'hff;
    $display ("STRU = %p", STRU); 
    $display ("STRU INTR = %h", STRU.intr);
    
    //STRU = 32'h 00_FFFFFF;
    //$display ("STRU = %p", STRU);//Unpacked not treated as vector 
    
    STRU = '{'h12,'h123456};
    $display ("STRU = %p", STRU);
    
    
    //STRU = 0; // Unpacked not treated as vector 
    //STRU = STRU + 'h123;//Only packed support this operations
    //$display ("STRU = %p", STRU);
  end
endmodule
