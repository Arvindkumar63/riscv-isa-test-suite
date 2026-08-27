//How can you generate Gray code sequences using SystemVerilog?
class gray_code;
  rand bit[3:0] arr[];
  
  constraint c2{ arr.size == 15;
                foreach( arr[i]) arr[i] == (i^(i>>1));}
  
endclass

module constraint_2;
  gray_code code;
  initial begin
    code = new();
    code.randomize();
    $display("%p",code.arr);
    $finish;
  end
endmodule
