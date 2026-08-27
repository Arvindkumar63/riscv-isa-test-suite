module memory_ops;
  reg [7:0] mem[7:0];
  integer i;

  initial begin

    //write operation
    for(i=0;i<8;i++)
    begin
    mem[i] = i*3 ;
    end
    

    //read operation
    $display("mem[4][7:4] = %b ",mem[4][7:4]); //partselect
    $display("mem[5][3] = %b",mem[5][3]);  // bitselect
  end

endmodule

