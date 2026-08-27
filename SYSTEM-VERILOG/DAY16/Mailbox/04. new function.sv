// new :Returns mailbox handle. An argument represents bounded mailbox size otherwise, it is an unbounded mailbox.
class A;
   int a;
   mailbox  m;

   function new(mailbox m1);
      this.m = m1;
   endfunction

   task check();
      if(m == null)begin
         $display("Mailbox is not created");
      end
      else
         $display("Mailbox is created");
     for(int i=0;i<3;i++)begin
            a++;
            m.put(a);
            $display("Value of a = %0d",a);
         end
    endtask
endclass

module  tb();
   A a1;
   mailbox mb = new(3);
   initial begin
     a1= new(mb);
     $display("--------------------------------------------------------------");
      a1.check();
     $display("--------------------------------------------------------------");
    end
endmodule

//OUTPUT
--------------------------------------------------------------
Mailbox is created
Value of a = 1
Value of a = 2
Value of a = 3
--------------------------------------------------------------
