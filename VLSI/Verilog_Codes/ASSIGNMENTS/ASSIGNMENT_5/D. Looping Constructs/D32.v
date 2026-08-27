module left_shift;
  reg [7:0]data;
  integer i;

  initial begin
    i=0; data=8'b00001111;
    while(data[7]==0)  begin
      data=data<<1;
      i++;
    end
    $display ("data = %b | count = %0d",data,i);
  end
endmodule

    
