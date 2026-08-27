// Randc type modifier
class randc_variable;
  randc bit [2:0]a;
endclass

module randc_var;
  randc_variable randc_handle=new();  
  initial begin
    $display("randc-The value of 'a' will repeat after completing one cycle");
    for(int i=0;i<=12;i++)
      begin
        void'(randc_handle.randomize());
        $display("Iteration=%0d    Random value=%0d",i,randc_handle.a);
      end
  end
endmodule


//OUTPUT
randc-The value of 'a' will repeat after completing one cycle
Iteration=0    Random value=0
Iteration=1    Random value=1
Iteration=2    Random value=4
Iteration=3    Random value=7
Iteration=4    Random value=3
Iteration=5    Random value=5
Iteration=6    Random value=2
Iteration=7    Random value=6
Iteration=8    Random value=1
Iteration=9    Random value=3
Iteration=10    Random value=2
Iteration=11    Random value=6
Iteration=12    Random value=7
