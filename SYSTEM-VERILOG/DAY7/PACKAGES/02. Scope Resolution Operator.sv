// Package items accessed using scope resolution operator
package pkg_A;
int data=5;
function pkg_func;
  $display("pkg_A : data = %0d",data);
endfunction
endpackage

package pkg_B;
int data=10;
function pkg_func;
  $display("pkg_B : data = %0d",data);
endfunction
endpackage

//---------------------------------
import pkg_A::*;
import pkg_B::*;
module package_eg;
  initial begin
    //pkg_func();//Errors: pkg_func cannot be resolved, as it is defined in package pkg_B and package pkg_A which are both wild card imported.
    pkg_A::pkg_func();
    pkg_B::pkg_func();
  end
endmodule
