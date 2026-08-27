// User defined Data type
module user_defined;
  // TYPEDEF STRUCTURE
  typedef struct{
    string name;
    logic[7:0] salary;
    bit[3:0] id;
  }employee;
  initial begin
    employee e1,e2;
    e1 = '{"DEEPA",'hFF,'hF};
    e2.name = "SARU";
    e2.salary = 'hEE;
    e2.id = 'hE;
    $display("----TYPEDEF STRUCTURE EXAMPLE----");
    $display ("EMPLOYEE 1" ,e1);
    $display ("EMPLOYEE 2" ,e2);
  end
  
  // TYPEDEF ENUM
  typedef enum {RED,YELLOW,GREEN,ORANGE}colour;
  initial begin
    colour a,b;
    a = RED;
    b = YELLOW;
    $display("----TYPEDEF ENUM EXAMPLE----");
    $display("COLOUR A =", a);
    $display("COLOUR B =", b);
  end

endmodule
