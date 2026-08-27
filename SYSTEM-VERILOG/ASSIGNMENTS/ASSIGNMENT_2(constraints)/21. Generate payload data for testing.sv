// Generate payload data for testing
class payload_test;
  rand bit[7:0] payload[];
  constraint c_payload_size {
    payload.size() == 64;
  }
  constraint c_payload_bytes{
    foreach(payload[i])
      payload[i] inside { [8'h00:8'hFF] };
  }
  constraint c_no_repeat{
    foreach(payload[i])
      if(i>0)
        payload[i] != payload[i-1];
  }
endclass

module payload_tb;
  payload_test p1;
  initial begin
    p1 = new();
    p1.randomize();
    $display("Payload = %0p", p1.payload);
  end
endmodule


//OUTPUT
Payload = 27 244 199 105 76 233 91 234 89 245 144 239 214 1 215 130 140 222 66 245 16 213 85 71 95 126 214 19 193 172 39 133 162 153 50 171 16 149 107 26 124 75 209 130 153 160 31 54 165 112 72 5 87 214 206 116 169 225 3 146 80 150 213 115
