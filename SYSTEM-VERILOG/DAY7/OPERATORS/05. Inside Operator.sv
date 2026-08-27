//Inside Operator
module inside_op;
  bit [3:0]bus_data;
  initial begin
    for(int i=0;i<10;i++)
      begin
        bus_data =$urandom;
        
        if(bus_data inside {1,3,[5:9],[11:14]})
          $display("bus_data=%0d 'inside' {1,3,[5:9],[11:14]}",bus_data);
        
        else
          $display("bus_data=%0d 'outside' {1,3,[5:9],[11:14]}",bus_data);
      end
  end
endmodule
