// Constraint to ensure two queues contain different elements.
class packet;
  rand bit[7:0] q1[];
  rand bit[7:0] q2[];
  
  constraint c1{
    q1.size() == 5;
    q2.size() == 5;
  }
  
  constraint c2{
    foreach(q1[i])
      foreach(q2[j])
        q1[i] != q2[j];
  }
  
endclass

module tb;
  packet pkt;
  initial begin
    pkt = new();
    repeat(10) begin
      pkt.randomize();
      $display("Two Queues Q1 = %0p , Q2 = %0p", pkt.q1, pkt.q2);
    end
  end
endmodule


//OUTPUT
# KERNEL: Two Queues Q1 = 197 47 48 181 32 , Q2 = 134 205 10 186 23
# KERNEL: Two Queues Q1 = 114 2 84 201 211 , Q2 = 16 109 239 139 15
# KERNEL: Two Queues Q1 = 48 170 40 75 210 , Q2 = 180 8 122 180 239
# KERNEL: Two Queues Q1 = 241 233 213 251 136 , Q2 = 221 227 31 134 144
# KERNEL: Two Queues Q1 = 137 222 27 179 224 , Q2 = 71 148 135 228 73
# KERNEL: Two Queues Q1 = 165 248 113 75 127 , Q2 = 252 226 26 129 234
# KERNEL: Two Queues Q1 = 90 136 214 41 12 , Q2 = 153 100 105 33 180
# KERNEL: Two Queues Q1 = 171 185 199 187 179 , Q2 = 197 254 174 196 98
# KERNEL: Two Queues Q1 = 141 144 180 59 95 , Q2 = 108 216 46 173 65
# KERNEL: Two Queues Q1 = 221 122 191 211 234 , Q2 = 226 202 87 79 232
