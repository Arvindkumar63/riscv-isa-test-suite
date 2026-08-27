primitive and_udp(y,a,b);
  input a,b;
  output y;

  table
  //a  b : y
    0  0 : 0;
    0  1 : 0;
    1  0 : 0;
    1  1 : 1;
  endtable

endprimitive
