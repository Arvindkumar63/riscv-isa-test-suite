primitive dlatch_udp(q,clk,d);
  output q;
  reg q;
  input clk,d;
  
  table
  //clk d : q : q_next
     1  0 : ? : 0;
     1  1 : ? : 1;
     0  ? : 0 : 0;
     0  ? : 1 : 1;
  endtable
endprimitive
