// Pass by name 
module passbyname;
  int salary;
  string name;
  task print(int salary,string name);
    $display("NAME = %s, SALARY = %0d", name, salary);
  endtask
  initial begin
    print(.name("DEEPA"), .salary(50000));
  end
endmodule
