   // Half adder
module half_adder(input a,b, output sum,carry);
xor x1(sum,a,b);
and a1(carry,a,b);
endmodule

   // Full adder from 2 half adders
module full_adder(input a,b,cin, output sum,cout);
wire s1,c1,c2;
half_adder ha1(.a(a),.b(b),.sum(s1),.carry(c1));
half_adder ha2(.a(s1),.b(cin),.sum(sum),.carry(c2));
or o1(cout,c1,c2);
endmodule
