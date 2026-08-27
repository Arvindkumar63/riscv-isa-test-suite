// Package examples
package pkg;
  class transaction;
    int data = 5;
    function void disp;
      $display("Data = %0d",data);
    endfunction
  endclass

  function void pkg_func;
    $display("Inside pkg_func");
  endfunction
endpackage


 //-------Import whole package----------
 import pkg :: *; // import whole package properties, functions
 module pkg_eg;
   initial begin
     transaction tr = new();
     tr.disp();
     pkg_func();
   end
 endmodule

//---------Import a single method----------
import pkg :: transaction; // import class transaction from the package
module pkg_eg;
  initial begin
    transaction tr = new();
    tr.disp();
    //pkg_func();// Error:Unresolved reference to 'pkg_func'
  end
endmodule
