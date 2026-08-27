// num: returns the no of messages present in a mailbox.
class A;
   int a;
   mailbox m;

   function new(mailbox m1);
      this.m = m1;
  endfunction

  task put_data();
    for(int i = 0; i < 3; i++) begin
      a++;
      m.put(a);
      $display("Transmitter: value of a = %0d", a);
      $display(" No of messages in mailbox = %0d", m.num());
    end
    $display("---------------------------------------------------------------");
  endtask
endclass

module tb();
   A a1;
   mailbox mb = new();

   initial begin
     a1 = new(mb);
     repeat(2) begin
       a1.put_data();
     end
   end
endmodule 

//OUTPUT
Transmitter: value of a = 1
 No of messages in mailbox = 1
Transmitter: value of a = 2
 No of messages in mailbox = 2
Transmitter: value of a = 3
 No of messages in mailbox = 3
---------------------------------------------------------------
Transmitter: value of a = 4
 No of messages in mailbox = 4
Transmitter: value of a = 5
 No of messages in mailbox = 5
Transmitter: value of a = 6
 No of messages in mailbox = 6
---------------------------------------------------------------
