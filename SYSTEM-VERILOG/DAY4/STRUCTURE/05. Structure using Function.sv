// Structure using Function
module structure_function;
  typedef struct{
    string Name;
    bit[31:0] Salary;
    integer id;
  } employee;
  
  function void print_struct(employee e);
    $display ("Employee = %p",e);
  endfunction
  
  function employee create_struct(string Name, bit[31:0] Salary, integer id);
    employee e;
    e.Name = Name;
    e.Salary = Salary;
    e.id = id;
    return e;
  endfunction
  
  initial begin
    employee e1, e2;
    e1 = create_struct("DEEPA",1234567,19);
    e2 = create_struct("SARU",7654321,23);
    print_struct(e1);
    print_struct(e2);
  end
endmodule
