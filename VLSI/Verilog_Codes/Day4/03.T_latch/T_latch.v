module tlatch(
  input T,en,rst,
  output reg Q);
  
  always @ (T or en or rst) begin
   if(rst)
     Q<=0;
   else if(en) begin
     if(T)
       Q<=~Q;
   end 
  end
endmodule   
