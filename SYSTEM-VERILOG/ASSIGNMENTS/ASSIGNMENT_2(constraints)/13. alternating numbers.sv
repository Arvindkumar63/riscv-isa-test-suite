// Generate a 12 bit variable with alternating numbers
class cons_13;
  rand bit [11:0] value [10];
  constraint c13{ foreach(value[i])
    if(i<9)
    value[i+1] == value[i] + 2; }
endclass

module constraint_13;
  cons_13 c1 = new();
  initial begin
    c1.randomize();
    foreach(c1.value[i]) 
      $display("value[%0d] = %0d", i, c1.value[i]);
  end
endmodule


//OUTPUT
value[0] = 167
value[1] = 169
value[2] = 171
value[3] = 173
value[4] = 175
value[5] = 177
value[6] = 179
value[7] = 181
value[8] = 183
value[9] = 185


class cons_13;
  rand bit [11:0] value;
  constraint c13{ foreach(value[i])
    value[i] + value[i+1] == 1; }
endclass

module constraint_13;
  cons_13 c1 = new();
  initial begin
    repeat(5) begin
    c1.randomize();
    $display("value = %0b", c1.value);
    end
  end
endmodule

//OUTPUT
# KERNEL: value = 101010101010
# KERNEL: value = 101010101010
# KERNEL: value = 101010101010
# KERNEL: value = 101010101010
# KERNEL: value = 101010101010
