//Driver
class driver;
  transaction tr;
  mailbox gen_to_driv;
  virtual inter inf;
  
  function new(virtual inter inf, mailbox gen_to_driv);
    this.inf = inf;
    this.gen_to_driv = gen_to_driv;
  endfunction
  
  task driv();
    tr = new();
    repeat(5) begin
      #1;
      gen_to_driv.get(tr);
      inf.a = tr.a;
      inf.b = tr.b;
      tr.display("Driver");
      #3;
    end
  endtask
endclass
