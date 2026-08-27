module mem_model2D;
  reg [7:0] mem[3:0][3:0];
  integer i,j;

  initial begin 
    
    //write operation
    for(i=0;i<4;i++)
    begin
    for(j=0;j<4;j++)
    begin
    mem[i][j] = i*5 + j;
    end
    end

    //read operation
    $display("--------2D Memory---------");
    for(i=0;i<4;i++)                                                                                                                                            begin                                                                                                                                                       for(j=0;j<4;j++)                                                                                                                                            begin                                                                                                                                                       $write("%d \t",mem[i][j]);   
    end
    $write("\n");
    end
  end

endmodule
