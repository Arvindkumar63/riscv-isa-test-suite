module top_module( 
    input [99:0] a, b,
    input cin,
    output [99:0] cout,
    output [99:0] sum );
    genvar i;
    full_adder FA(.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(cout[0]));
    generate
        for(i=1;i<100;i++) begin:fulladder
            full_adder FA1(.a(a[i]), .b(b[i]), .cin(cout[i-1]), .sum(sum[i]), .cout(cout[i]));
        end
    endgenerate
endmodule

module full_adder(
    input a,b,cin,
    output sum, cout);
    assign sum = a^b^cin;
    assign cout = (a&b)|(b&cin)|(cin&a);
endmodule
