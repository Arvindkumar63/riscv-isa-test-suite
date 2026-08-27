// Nested Package
package pkg_A;
int data = 5;
int id_A = 1;
function void pkg_fn;
  $display("pkg_A:data = %0d  id_A = %0d",data, id_A);
endfunction 
endpackage

package pkg_B;
import pkg_A::*;
int data = 10;
int id_B = 2;
function void pkg_fn;
  $display("pkg_B:data = %0d  id_B = %0d",data, id_B);
endfunction 
endpackage

//------------------------------------------
import pkg_B::*;
module package_eg;
  initial begin
    pkg_A::pkg_fn();
    pkg_B::pkg_fn();
  end
endmodule
