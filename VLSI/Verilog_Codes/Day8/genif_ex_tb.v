module genif_ex_tb;
reg a,b,c;
wire sum,carry;

genif_ex uut(.a(a), .b(b), .c(c), .sum(sum), .cout(carry));

//defparam uut.sel = 0;

defparam uut.sel = 1;

initial begin
$monitor("A=%b B=%b C=%b  sum=%b Carry=%b" , a,b,c,sum,carry);
a=1; b=0; c=1; 
#10;
a=1; b=1; c=1;
#10;
a=0; b=1; c=1;
#10;
$finish;
end

endmodule
