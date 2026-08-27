// Static Constraint
class class1;  
  rand bit [2:0] value;  
  constraint cons { value == 1; }  
endclass  


class class2;  
  rand bit [2:0] value;  
  // Static constraint: Applies to all instances of this class  
  static constraint cons { value == 1; }  
endclass  

module static_constraint();
  class1 object_1, object_2;
  class2 object_3, object_4;
  initial begin 
    object_1 = new();  
    object_2 = new();  
    object_3 = new();  
    object_4 = new();
    
    // Disable constraint for object_1 (non-static constraint)  
    object_1.cons.constraint_mode(0);  
    $display("------------- Non-static constraint turned off only in object 1 ---------------");  

    // Randomize and display values for object_1 and object_2  
    for (int i = 1; i <= 3; i++) begin  
      object_1.randomize();  
      object_2.randomize();  
       $display("Iteration: %0d -----> value in object_1: %0d  value in object_2: %0d", i, object_1.value, object_2.value);  
    end  

    // Disable constraint for object_3 (static constraint)  
    object_3.cons.constraint_mode(0);  
    $display("------------ Static constraint turned off only in object 3 -------------");  

    // Randomize and display values for object_3 and object_4  
    for (int i = 1; i <= 3; i++) begin  
      object_3.randomize();  
      object_4.randomize();  
       $display("Iteration: %0d -----> value in object_3: %0d  value in object_4: %0d", i, object_3.value, object_4.value);  
    end  
  end  
endmodule 

//OUTPUT
# KERNEL: ------------- Non-static constraint turned off only in object 1 ---------------
# KERNEL: Iteration: 1 -----> value in object_1: 3  value in object_2: 1
# KERNEL: Iteration: 2 -----> value in object_1: 2  value in object_2: 1
# KERNEL: Iteration: 3 -----> value in object_1: 4  value in object_2: 1
# KERNEL: ------------ Static constraint turned off only in object 3 -------------
# KERNEL: Iteration: 1 -----> value in object_3: 7  value in object_4: 6
# KERNEL: Iteration: 2 -----> value in object_3: 2  value in object_4: 7
# KERNEL: Iteration: 3 -----> value in object_3: 6  value in object_4: 1


