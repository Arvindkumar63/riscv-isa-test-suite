//Create a 61-bit variable constraint such that bits 0-31 are 1 and the remaining bits are 0.
class var_cons;
  rand bit[60:0] data;
  
  constraint c4{ data[31:0] == '1;
                data[60:32] == '0;}
  
endclass

module constraint_4;
  var_cons v1;
    initial begin
      v1 = new();
      v1.randomize();
      $display("%0h", v1.data);//Expected output = ffff_ffff
      $finish;
    end
endmodule
