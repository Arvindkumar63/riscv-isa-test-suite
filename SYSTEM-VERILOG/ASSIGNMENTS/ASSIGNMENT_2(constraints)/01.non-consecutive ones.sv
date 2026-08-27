// Write a constraint for a 32-bit variable such that exactly 12 non-consecutive 1's are generated.
class non_consec_one;
  rand bit [31:0] data;
  
  constraint c1 { $countones(data) == 12;
              foreach(data[i])
                if(i<31) data[i] +data[i+1] != 2; }
  
  function void print;
    $display("Generated data = %0b(%0d)" , data,data);
  endfunction
  
endclass

module constraint_1;
  non_consec_one ones;
  initial begin
    ones = new();
    repeat(10) begin
      ones.randomize();
      ones.print();
    end
    $finish;
  end
endmodule
