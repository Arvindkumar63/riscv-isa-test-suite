//Inheritance worldcup-ex
class world_cup_19;
  bit [15:0] premium_ticket;
  function league_match();
    $display("Premium Ticket Rate = %0d",premium_ticket);
  endfunction
endclass

class world_cup_23 extends world_cup_19;
  bit [15:0] golden_ticket;
  function semi_final();
    $display("Golden Ticket Rate = %0d",golden_ticket);
  endfunction
  function final_match(); // To display both premium and golden tickets
    league_match();
    semi_final();
  endfunction
endclass

module example;
  world_cup_23 wc = new();
  initial begin
    wc.premium_ticket = 1000;
    wc.golden_ticket = 500;
    wc.league_match();
    wc.semi_final();
    wc.final_match();
  end
endmodule

//OUTPUT
Premium Ticket Rate = 1000
Golden Ticket Rate = 500
Premium Ticket Rate = 1000
Golden Ticket Rate = 500
