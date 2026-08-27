// This keyword  
class base_class;
  string fan ="OFF" ; 
  string switch="OFF"; 
   
  function void open_electricity();
    string fan="ON";
    string switch="ON";
    this.fan=fan; //this keyword before the fan and switch then it  print the value switch is ON and fan is also ON inside the class as well as outside the class.//overwrite the class object proprties outside the method.
    this.switch=switch;
    $display("Inside class method :- switch is %0s that's why fan is %0s",switch,fan);
  endfunction
endclass

module check_electricity;
  base_class b1;
  
  initial begin
    b1=new();
    b1.open_electricity;
    $display("Outside class :- switch is %0s that's why fan is %s",b1.switch,b1.fan);
  end
endmodule


//without This keyword
class base_class; 
  string fan ="OFF" ;
  string switch="OFF";

  function void open_electricity();
    string fan="ON";
    string switch="ON";
    fan=fan; //inside the method it display the overwrite value of properties but outside the class it display the default or given value of properties
    switch=switch;
    $display("Inside class method :- switch is %0s that's why fan is %0s",switch,fan);
  endfunction
endclass

module check_electricity; 
  base_class b1;

  initial begin
    b1=new();
    b1.open_electricity;
    $display("Outside class :- switch is %0s that's why fan is %s",b1.switch,b1.fan);
  end
endmodule
