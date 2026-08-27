module gencase_ex #(parameter sel = 0)
(input a,b,c,
 output sum,cout);

generate
  case(sel) 
 1: begin	  
    initial $display("Full Adder instantiated");
    full_adder f(a,b,c,sum,cout);
    end

 0: begin
    initial $display("Half Adder instantiated");
    half_adder h(a,b,sum,cout);
    end
  endcase
endgenerate
endmodule

module full_adder( input a,b,c,
	output sum,carry);

assign {carry,sum} = a+b+c;
endmodule

module half_adder(input a,b,
	output sum,carry);
assign {carry,sum} = a+b;
endmodule
