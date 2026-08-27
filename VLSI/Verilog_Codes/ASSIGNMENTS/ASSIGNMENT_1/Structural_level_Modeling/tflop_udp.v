primitive tflop_udp(q,clk,t,rst);
  input clk,t,rst;
  output q;
  reg q;
  
  table 
  //clk  t rst  : q : q_next
     ?   ?  1   : ? : 0;
   (01)  0  0   : 0 : 0;
   (01)  0  0   : 1 : 1;
   (01)  1  0   : 0 : 1;
   (01)  1  0   : 1 : 0;
    ?    ?  0   : ? : -;
  endtable
endprimitive
