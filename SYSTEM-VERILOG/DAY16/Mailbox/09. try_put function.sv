// try put :  tries to put the data in a non blocking manner to store a message in the mailbox if not full. If successful returns 1 else 0.
class A;
  int a;
  mailbox m;
  
  function new(mailbox m1);
    this.m = m1;
  endfunction
  
  task put_data;
    for(int i=0; i<3; i++) begin
      a++;
      if(m.try_put(a))
        $display("1. Transmitter: value of a = %0d",a);
      else
        $display("failed while trying to put the data = %0d", a);
    end
    $display("----------------------------------------------------");
  endtask
endclass

class B;
  int a;
  mailbox m;
  
  function new(mailbox m2);
    this.m = m2;
  endfunction
  
  task get_data;
    begin
      m.get(a);
      $display("1. Receiver: value of a = %0d",a);
    end
  endtask
endclass

module tb;
  A a1;
  B b1;
  mailbox mb = new(3);
  
  initial begin
    a1 = new(mb);
    b1 = new(mb);
    
    repeat (2) begin
      a1.put_data;
      $display("---------------------------------------------------------");
      b1.get_data;
    end
  end
endmodule


//OUTPUT
1. Transmitter: value of a = 1
1. Transmitter: value of a = 2
1. Transmitter: value of a = 3
----------------------------------------------------
---------------------------------------------------------
1. Receiver: value of a = 1
1. Transmitter: value of a = 4
failed while trying to put the data = 5
failed while trying to put the data = 6
----------------------------------------------------
---------------------------------------------------------
1. Receiver: value of a = 2
