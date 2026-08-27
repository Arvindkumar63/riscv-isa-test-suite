//Dynamic array randomization
class dyn_arr_rand;
  randc bit [7:0] dyn_arr[];
  constraint dyn_arr_size {dyn_arr.size()>3; 
                           dyn_arr.size() <7;}
  constraint dyn_arr_elem { foreach(dyn_arr[i])
    dyn_arr [i] == i*i;  }
endclass

module mod;
  initial begin
    dyn_arr_rand pack = new();
    for (int j=0; j<5; j++) begin
      void'(pack.randomize());
      $display("Iteration = %0d , Array = %0p ",j,pack.dyn_arr);
    end
  end
endmodule

//OUTPUT
# KERNEL: Iteration = 0 , Array = 0 1 4 9 16 
# KERNEL: Iteration = 1 , Array = 0 1 4 9 16 
# KERNEL: Iteration = 2 , Array = 0 1 4 9 16 25 
# KERNEL: Iteration = 3 , Array = 0 1 4 9 
# KERNEL: Iteration = 4 , Array = 0 1 4 9 16 25 
