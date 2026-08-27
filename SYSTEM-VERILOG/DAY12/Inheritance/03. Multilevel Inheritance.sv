// Multilevel Inheritance
class parent_class;
  bit[31:0] data_p;
  function void disp_p();
    $display("Value of data_p = %0h",data_p);
  endfunction
endclass

class child1_class extends parent_class;
  bit[31:0] data_c1;
  function void disp_c1();
    $display("Value of data_c1 = %0h",data_c1);
  endfunction
endclass

class child2_class extends parent_class;
  bit[31:0] data_c2;
  function void disp_c2();
    $display("Value of data_c2 = %0h",data_c2);
  endfunction
endclass

class childA_class extends child1_class;
  bit[31:0] data_cA;
  function void disp_cA();
    $display("Value of data_cA = %0h",data_cA);
  endfunction
endclass

class childB_class extends childA_class;
  bit[31:0] data_cB;
  function void disp_cB();
    $display("Value of data_cB = %0h",data_cB);
  endfunction
endclass

module class_example;
  initial begin
    childB_class cB_class = new();
    cB_class.data_p = 2;
    cB_class.data_c1 = 3;
    //cB_class.data_c2 = 4; //Could not find field/method name (data_c2) in 'cB_class'
    cB_class.data_cA = 5;
    cB_class.data_cB = 6;
    
    cB_class.disp_p();
    cB_class.disp_c1();
    //cB_class.disp_c2(); //Could not find field/method name (disp_c2) in 'cB_class'
    cB_class.disp_cA();
    cB_class.disp_cB();
  end
endmodule
