// Parameterized Mailbox 
class A;
   string country;
   string place;
   mailbox #(string) m;

  function new(mailbox #(string) m1);
      this.m = m1;
   endfunction

   task put_data();
      country = "India";
      place = "Kashmir";
      m.put(country);
      m.put(place);
     $display("Transmitter: Country = %0s ,place = %0s",country,place);
     
      country = "South Africa";
      place = "Cape Town";
      m.put(country);
      m.put(place);
      $display("Transmitter: Country = %0s ,place = %0s",country,place);
     
      country = "Spain";
      place = "Barcelona";
      m.put(country);
      m.put(place);
      $display("Transmitter: Country = %0s ,place = %0s",country,place);
   endtask
endclass

class B;
   string country;
   string place;
   mailbox #(string) m;

  function new(mailbox #(string) m2);
      this.m = m2;
   endfunction

   task get_data();
       m.get(country);
       m.get(place);
       $display("Receiver: Country = %0s ,place = %0s",country,place);

        m.get(country);
        m.get(place);
        $display("Receiver: Country = %0s ,place = %0s",country,place);

        m.get(country);
        m.get(place);
        $display("Receiver: Country = %0s ,place = %0s",country,place);
   endtask
endclass

module  tb();
   A a1;
   B b1;
   int i;
  mailbox #(string) mb = new(6);
   initial begin
     a1= new(mb);
     b1 = new(mb);
      a1.put_data();
     $display("----------------------------------------------------------");
      b1.get_data();
   end
endmodule

//OUTPUT
Transmitter: Country = India ,place = Kashmir
Transmitter: Country = South Africa ,place = Cape Town
Transmitter: Country = Spain , place = Barcelona
----------------------------------------------------------
Receiver: Country = India , place = Kashmir
Receiver: Country = South Africa , place = Cape Town
Receiver: Country = Spain , place = Barcelona
