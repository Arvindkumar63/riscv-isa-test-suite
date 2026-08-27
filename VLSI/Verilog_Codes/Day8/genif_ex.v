module genif_ex #(parameter sel = 0)
(input a,b,c,
 output sum,cout);

generate
  if(sel) begin
    initial $display("Full Adder instantiated");
    full_adder f(a,b,c,sum,cout);
  end
  else begin
    initial $display("Half Adder instantiated");
    half_adder h(a,b,sum,cout);
  end
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
