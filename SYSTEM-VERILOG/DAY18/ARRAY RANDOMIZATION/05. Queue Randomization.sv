// Queue Randomization
class queue_rand;  
  rand bit [4:0] que[$];  
  constraint que_size { que.size() == 5; }  
endclass  

module mod;    
  initial begin
    queue_rand pack = new();
      
    for (int i = 0; i < 5; i++) begin  
      void'(pack.randomize());
      $display("Iteration = %0d,  array = %0p", i, pack.que);  
    end  
  end  
endmodule  

//OUTPUT
Iteration = 0,  array = '{'h16, 'hf, 'h3, 'h0, 'h15}
Iteration = 1,  array = '{'h1e, 'h1d, 'h17, 'h1, 'h19}
Iteration = 2,  array = '{'h14, 'h1f, 'h11, 'h2, 'h3}
Iteration = 3,  array = '{'h3, 'h12, 'h1c, 'h17, 'hb}
Iteration = 4,  array = '{'h13, 'hc, 'hc, 'h15, 'h7}
