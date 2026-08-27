module equation;
  reg a,b,c,d,e;
  wire y;

  wire nb, nc, nd;
  not #4(nb,b);
  not #4(nc,c);
  not #4(nd,d);

  wire a1,a2,a3,a4,a5,a6;
  and #3(a1,a,nb);
  and #3(a2,a1,nc);
  and #3(a3,a,b);
  and #3(a4,a3,e);
  and #3(a5,nb,c);
  and #3(a6,c,nd);

  wire o1,o2;
  or #2(o1,a2,a4);
  or #2(o2,o1,a5);
  or #2(y,o2,a6);

  initial begin
	  $monitor("TIME = %3t A=%b B=%b C=%b D=%b E=%b Y=%b",$time,a,b,c,d,e,y);
          a=1; b=0; c=1; d=0; e=1;
	  #10
	  $monitoroff;
	  #50 $monitoron;
	  #200 $finish;
  end
  endmodule

