// Generic Mailbox - Bounded
class A;
  int a;
  mailbox m;

  function new(mailbox m1);
    this.m = m1;
  endfunction

  task data();
    for(int i = 0; i < 3; i++) begin 
      if(m.num() == 2) begin
        $display("Mailbox is full");
      end 
      else begin
        a++;
        m.put(a);
        $display("%0t 1. Transmitter: value of a = %0d", $time, a);
      end 
    end 
  endtask   
endclass


class B; 
  int a;
  mailbox m;
        
  function new(mailbox m2);
    this.m = m2;
  endfunction
               
  task ret_data();
    begin 
      m.get(a);
      $display("%0t 2. Receiver: value of a = %0d", $time, a);
    end 
  endtask
endclass


module tb();                                            
  A a1;
  B b1;
  mailbox mb = new(2); // Bounded size = 2
                                             
  initial begin
    a1 = new(mb);
    b1 = new(mb);

    repeat(3) begin 
      a1.data();
      $display("...............................................");
      b1.ret_data();
    end
  end

endmodule

//OUTPUT
0 1. Transmitter: value of a = 1
0 1. Transmitter: value of a = 2
Mailbox is full
...............................................
0 2. Receiver: value of a = 1
0 1. Transmitter: value of a = 3
Mailbox is full
Mailbox is full
...............................................
0 2. Receiver: value of a = 2
0 1. Transmitter: value of a = 4
Mailbox is full
Mailbox is full
...............................................
0 2. Receiver: value of a = 3
