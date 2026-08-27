// peek : This method copies one message from the mailbox without removing the message from the mailbox queue.
class A;
  int a;
  mailbox m;
  
  function new(mailbox m1);
    this.m = m1;
  endfunction
  
  task put_data;
    for(int i = 0; i<3; i++) begin
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
  
  task peek_data;
    for (int i = 0; i<3; i++) begin
      m.peek(a);
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
      b1.peek_data;
      $display("---------------------------------------------------------");
  end
endmodule

//OUTPUT
1. Transmitter: value of a = 1
1. Transmitter: value of a = 2
1. Transmitter: value of a = 3
------------------------------------------------------
---------------------------------------------------------
1. Receiver: value of a = 1
1. Receiver: value of a = 1
1. Receiver: value of a = 1
---------------------------------------------------------
