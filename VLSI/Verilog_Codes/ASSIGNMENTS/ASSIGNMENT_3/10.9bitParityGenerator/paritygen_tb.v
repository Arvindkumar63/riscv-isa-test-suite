module paritygen_tb;
  reg [8:0]data;
  wire ep,op;

  paritygen uut (.data(data), .ep(ep), .op(op));
  
  initial begin 
    $monitor("TIME= %t | DATA= %b | EvenParity= %b | OddParity= %b",$time,data,ep,op);
    
    data=9'b110100111; #10;
    data=9'b111000011; #10;
    $finish;
  end 
endmodule

