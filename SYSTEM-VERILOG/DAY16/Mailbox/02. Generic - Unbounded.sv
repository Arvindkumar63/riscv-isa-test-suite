// Generic Mailbox - Unbounded
class A;
  int a;
  mailbox m;

  function new(mailbox m1);
    this.m = m1;
  endfunction

  task put_data();
    for (int i = 0; i < 3; i++) begin 
      a++;
      m.put(a);
      $display("1. Transmitter: value of a = %0d", a);
    end
  endtask
endclass


class B;
  int a;
  mailbox m;

  function new(mailbox m2);
    this.m = m2;
  endfunction

  task get_data();
    for (int i = 0; i < 2; i++) begin 
      m.get(a);
      $display("2. Receiver: value of a = %0d", a);
    end 
  endtask
endclass


module tb();
  A a1;
  B b1;
  mailbox mb = new();

  initial begin
    a1 = new(mb);
    b1 = new(mb);
    repeat(2) begin
      a1.put_data();
      $display("-----------------------------------------------");     
      b1.get_data();
      $display("-----------------------------------------------"); 
    end
  end  
endmodule 

//OUTPUT
1. Transmitter: value of a = 1
1. Transmitter: value of a = 2
1. Transmitter: value of a = 3
-----------------------------------------------
2. Receiver: value of a = 1
2. Receiver: value of a = 2
-----------------------------------------------
1. Transmitter: value of a = 4
1. Transmitter: value of a = 5
1. Transmitter: value of a = 6
-----------------------------------------------
2. Receiver: value of a = 3
2. Receiver: value of a = 4
-----------------------------------------------
