// Disable Constraint
class packet;
  rand bit [3:0] data;
  constraint data_range { data inside {5, 10, 15}; }
endclass

module constraint_mode;
  packet pkt;

  initial begin
    pkt = new();
    $display("If constraint mode is 1, it will display 5, 10, or 15");
    $display("If constraint mode is 0, it will display random values");

    $display("----------Before Constraint disable----------");
    $display("Value of constraint mode = %0d", pkt.data_range.constraint_mode());
    pkt.randomize();
    $display("\t data = %0d", pkt.data);

    pkt.data_range.constraint_mode(0);

    $display("-----------After Constraint disable----------");
    $display("Value of constraint mode = %0d", pkt.data_range.constraint_mode());

    repeat (5) begin
      pkt.randomize();
      $display("\t data = %0d", pkt.data);
    end
  end
endmodule  


//OUTPUT
If constraint mode is 1, it will display 5, 10, or 15
If constraint mode is 0, it will display random values
----------Before Constraint disable----------
Value of constraint mode = 1
	 data = 15
-----------After Constraint disable----------
Value of constraint mode = 0
	 data = 15
	 data = 5
	 data = 13
	 data = 2
	 data = 2
