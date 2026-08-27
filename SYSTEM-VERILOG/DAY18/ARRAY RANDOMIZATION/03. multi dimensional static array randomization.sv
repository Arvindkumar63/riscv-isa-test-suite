// multi- dimensional static array
class static_array_multi;
  rand bit[3:0] a [3][4];
  constraint cons{
    foreach(a[i])
      a[i].sum() with (int'(item)) == 12;}
endclass

module mod;
  static_array_multi pack;
  initial begin
    pack = new();
    $display("Before randomization");
    $display("Array = %0p ", pack.a);
    for (int j = 0; j<5; j++) begin
    void'(pack.randomize());
    $display("After randomization");
    $display("Array = %0p ", pack.a);
    end
  end
endmodule

//OUTPUT
Before randomization
Array = '{'{'h0, 'h0, 'h0, 'h0}, '{'h0, 'h0, 'h0, 'h0}, '{'h0, 'h0, 'h0, 'h0}} 
After randomization
Array = '{'{'hc, 'h0, 'h0, 'h0}, '{'h0, 'h0, 'hb, 'h1}, '{'h0, 'h0, 'h0, 'hc}} 
After randomization
Array = '{'{'h3, 'h1, 'h0, 'h8}, '{'h0, 'h8, 'h0, 'h4}, '{'h0, 'h1, 'hb, 'h0}} 
After randomization
Array = '{'{'h4, 'h8, 'h0, 'h0}, '{'h4, 'h4, 'h4, 'h0}, '{'h4, 'h3, 'h5, 'h0}} 
After randomization
Array = '{'{'h0, 'h0, 'h8, 'h4}, '{'h4, 'h0, 'h8, 'h0}, '{'h3, 'h0, 'h0, 'h9}} 
After randomization
Array = '{'{'h6, 'h2, 'h0, 'h4}, '{'h5, 'h7, 'h0, 'h0}, '{'h3, 'h6, 'h2, 'h1}} 
