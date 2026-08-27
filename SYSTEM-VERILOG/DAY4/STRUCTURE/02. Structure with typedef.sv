//Structure with typedef
module struct_typedef;
  typedef struct {
    string name;
    bit[31:0] salary;
    integer id;
  } employee;
    
  initial begin
    employee e1,e2,e3;
    e1.name = "Deepa";
    e1.salary = 'h123000;
    e1.id     = 'd19;
    $display("employee: %p", e1);
    
    e2.name = "Saru";
    e2.salary = 'h120000;
    e2.id     = 'd23;
    $display("employee: %p", e2);
    
    e3.name = "Harini";
    e3.salary = 'h100000;
    e3.id     = 'd01;
    $display("employee: %p", e3);
    
    // Accessing individual struct member
    $display("employee: name = %s, salary = 0x%0h, id = %0d", e1.name, e1.salary, e1.id);
    $display("employee: name = %s, salary = 0x%0h, id = %0d", e2.name, e2.salary, e2.id);
    $display("employee: name = %s, salary = 0x%0h, id = %0d", e3.name, e3.salary, e3.id);
  end
endmodule
