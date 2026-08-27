// new :Returns mailbox handle. An argument represents bounded mailbox size otherwise, it is an unbounded mailbox.
class A;
   int a;
   mailbox  m;

   function new(mailbox m1);
      this.m = m1;
   endfunction

   function void check();
      if(m == null)begin
         $display("Mailbox is not created");
      end
      else
         $display("Mailbox is created");
   endfunction

   task put_data();
     for(int i=0; i<5; i++) begin
         m.put(a);
         a++;
         $display("Value of a = %0d", a);
      end
      $display("No of messages in mailbox = %0d", m.num());
   endtask
endclass

module tb();
   A a1;
   mailbox mb = new();

   initial begin
     a1 = new(mb);
     $display("----------------------------------------------------------");
     a1.check();
      repeat(2) begin
        $display("--------------------------------------------------------");
         a1.put_data();
      end
   end
endmodule

//OUTPUT
----------------------------------------------------------
Mailbox is created
--------------------------------------------------------
Value of a = 1
Value of a = 2
Value of a = 3
Value of a = 4
Value of a = 5
No of messages in mailbox = 5
--------------------------------------------------------
Value of a = 6
Value of a = 7
Value of a = 8
Value of a = 9
Value of a = 10
No of messages in mailbox = 10
