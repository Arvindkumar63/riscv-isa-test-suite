// Associative Arrays Copy and Compare
module assoc;
  int ass_arr1[string];
  int ass_arr2[string];
  task compare;
    foreach(ass_arr1[i])
      if(ass_arr1[i] == ass_arr2[i])
        $display("Both are equal", ass_arr1[i],ass_arr2[i]);
      else
        $display("Both are equal", ass_arr1[i],ass_arr2[i]);
  endtask
  
  initial begin
    ass_arr1["districts"] = 32;
    ass_arr1["states"] = 28;
    ass_arr2 = ass_arr1;
    compare();
  end
endmodule
