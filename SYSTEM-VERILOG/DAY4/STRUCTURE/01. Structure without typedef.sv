// Structure without typedef
module struct_no_typedef;
  struct {
    string name;
    bit[31:0] salary;
    integer id;
  } employee;
    
  initial begin
    employee.name = "Alexa";
    employee.salary = 'h2536;
    employee.id     = 'd1234;
    $display("employee: %p", employee);
    
    // Accessing individual struct member
    $display("employee: name = %s, salary = 0x%0h, id = %0d", employee.name, employee.salary, employee.id);
  end
endmodule
