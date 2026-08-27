// New and Delete Operator with dynamic array
module new_del;
  int d[];
  initial begin
    d = new[6];//Allocates memory
    d = '{1,2,3,4,5,6};
    $display("SIZE is",$size(d));
    d.delete();//Deallocate Memory
    $display("SIZE is",$size(d));
  end
endmodule
