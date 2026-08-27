module mem_model1D;
  reg [7:0] mem[7:0];
  integer i;

  initial begin 
    //write operation
    mem[0]=8'haa;
    mem[1]=8'd30;
    mem[2]=8'b10111100;
    mem[3]=8'o277;

    //read operation
    for(i=0; i<8; i++)
    begin
    $display("mem[%0d] = %b(BINARY) , %d(DECIMAl) , %h(HEXADECIMAL) ", i, mem[i], mem[i], mem[i]);
    end
    //finish;
  end

endmodule
