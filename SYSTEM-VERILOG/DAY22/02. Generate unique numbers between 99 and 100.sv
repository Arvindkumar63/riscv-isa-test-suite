// Generate unique numbers between 99 and 100
class cons;
  rand int number;
  constraint c1{ number inside {[9900:10000]};}
endclass

module tb;
  cons pkt;
  real act_val;
  initial begin
    pkt = new();
    void'(pkt.randomize());
    
    act_val = pkt.number / 100.0; // result is float ...
    $display("Actual value = %0f" , act_val);
  end
endmodule



//OUTPUT
Actual value = 99.550000
