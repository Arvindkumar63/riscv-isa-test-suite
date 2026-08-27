// Constraint Conflict
///////////////////WITH CONFLICT///////////////////////////
class cls;
    rand bit [3:0] a;
    constraint c1 { a < 10; }
    constraint c2 { a > 10; }
endclass

module pkt;
    cls cl;
    initial begin
        cl = new();
        if (cl.randomize()) begin
            $display(" Randomize successfully");
          $display(" The randomize value of a = %0d", cl.a);
        end
        else begin
            $display("Randomization fail because conflict occurs");
            $display("The value of a = %0d", cl.a);
        end
    end
endmodule

//OUTPUT
# KERNEL: Randomization fail because conflict occurs
# KERNEL: The value of a = 0


///////////////////WITHOUT CONFLICT/////////////////
class cls;
    rand bit [3:0] a;
    constraint c1 { a < 10; }
  constraint c2 { a  > 5; }
endclass

module pkt;
    cls cl;
    initial begin
        cl = new();
        if (cl.randomize()) begin
            $display(" Randomize successfully");
          $display(" The randomize value of a = %0d", cl.a);
        end
        else begin
            $display("Randomization fail because conflict occurs");
            $display("The value of a = %0d", cl.a);
        end
    end
endmodule


//OUTPUT
# KERNEL:  Randomize successfully
# KERNEL:  The randomize value of a = 9
