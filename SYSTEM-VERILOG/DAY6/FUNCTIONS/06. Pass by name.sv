// Pass by name 
module passbyname;
  int salary;
  string name;
  function void print(int salary,string name);
    $display("NAME = %s, SALARY = %0d", name, salary);
  endfunction
  initial begin
    print(.name("DEEPA"), .salary(50000));
  end
endmodule
