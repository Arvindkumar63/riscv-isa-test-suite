class transaction #(parameter Width);
  bit rst;
  rand bit wr_en;
  rand bit rd_en;
  rand bit [Width-1 : 0] d_in;
  
  bit [Width-1 : 0] d_out;
  bit full;
  bit empty;
  
  function void disp(string name);
    $display("---------------%s--------------",name);
    $display("$time=%0t | rst=%0b | wr_en=%0b | rd_en=%0b | d_in=%0b",$time,rst,wr_en,rd_en,d_in);
  endfunction
  
  function void mon_disp(string name);
     $display("---------------%s--------------",name);
    $display("$time=%0t | rst=%0b | wr_en=%0b | rd_en=%0b | d_in=%0d | d_out=%0d | full=%0b | empty=%0b " ,$time,rst,wr_en,rd_en,d_in,d_out,full,empty);
  endfunction
  
  constraint c1 { 
    wr_en -> d_in inside { [0 : (1<<Width)-1] };
    !wr_en -> d_in == 0;
  }
  
  constraint c2 {
    wr_en dist { 1:=50, 0:=50 }; 
    rd_en dist { 1:=50, 0:=50 };
  }
  
  constraint c3{ 
    wr_en != rd_en;
  }
  
endclass
