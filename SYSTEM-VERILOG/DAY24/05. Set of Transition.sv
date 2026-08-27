// Set of Transition
module set_trans;

  bit [3:0] a;
  bit [2:0] value[] = '{1,2,3,4,5};

  covergroup cvgrp;
    c1 : coverpoint a {
      bins tran_1 = (1,2 => 3,4);
      bins tran_2 = (3,4 => 5);
    }
  endgroup// bin trans creates 2 bin for covering 1=>3, 2=>3, 1=>4, 2=>4, 3=>5, 4=>5

  cvgrp cg = new();

  initial begin
    foreach(value[i]) begin
      a = value[i];
      cg.sample();
      $display("val = %d, coverage %%= %.2f ", a, cg.get_inst_coverage());
    end
  end
endmodule

//OUTPUT
# KERNEL: val =  1, coverage %= 0.00 
# KERNEL: val =  2, coverage %= 0.00 
# KERNEL: val =  3, coverage %= 50.00 
# KERNEL: val =  4, coverage %= 50.00 
# KERNEL: val =  5, coverage %= 100.00 
