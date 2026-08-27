// Get : Retrieve one message from the mailbox, if mailbox is empty it will block the process.
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
  
      a1.put_data;
      $display("---------------------------------------------------------");
      b1.get_data;
  end
endmodule

//OUTPUT
1. Transmitter: value of a = 1
------------------------------------------------------
---------------------------------------------------------
1. Receiver: value of a = 1 // after get 1 --> mailbox empty, put will block the execution.
