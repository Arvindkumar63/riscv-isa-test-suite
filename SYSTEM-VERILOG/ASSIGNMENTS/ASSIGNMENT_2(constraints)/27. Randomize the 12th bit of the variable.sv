// Randomize the 12th bit of the variable
class bit12_rand;
  rand bit bit12;          
  bit [15:0] data;        

  function void post_randomize();
    data[12] = bit12;      
  endfunction

endclass

module tb;
  bit12_rand p;
  initial begin
    p = new();
    p.data = 16'hABAB;  
    repeat (5) begin
      p.randomize();
      $display("Data = %h", p.data);
    end
  end
endmodule


//OUTPUT
# KERNEL: Data = abab
# KERNEL: Data = bbab
# KERNEL: Data = bbab
# KERNEL: Data = abab
# KERNEL: Data = bbab
