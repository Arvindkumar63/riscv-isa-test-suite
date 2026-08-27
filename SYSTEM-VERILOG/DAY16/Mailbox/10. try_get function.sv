// try_get : This is a non-blocking method which tries to get one message from the mailbox, returns 0 if mailbox is empty.
class A;
  int a;
  mailbox m;
  
  function new(mailbox m1);
    this.m = m1;
  endfunction
  
  task put_data;
    begin
      a++;
      m.put(a);
      $display("1. Transmitter: value of a = %0d",a);
    end
    $display("------------------------------------------------------");
  endtask
endclass

class B;
  int a;
  mailbox m;
  
  function new(mailbox m2);
    this.m = m2;
  endfunction
  
  task get_data;
    for (int i = 0; i<3; i++) begin
      if(m.try_get(a))
        $display("1. Receiver: value of a = %0d",a);
      else
        $display("Failed to receive while mailbox is empty");
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
  
      a1.put_data;
      $display("---------------------------------------------------------");
      b1.get_data;
  end
endmodule


//OUTPUT
1. Transmitter: value of a = 1
------------------------------------------------------
---------------------------------------------------------
1. Receiver: value of a = 1
Failed to receive while mailbox is empty
Failed to receive while mailbox is empty
