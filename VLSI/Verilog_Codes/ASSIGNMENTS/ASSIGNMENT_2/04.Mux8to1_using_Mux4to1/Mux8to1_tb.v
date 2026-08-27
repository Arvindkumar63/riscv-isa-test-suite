module Mux8to1_tb;
    reg [7:0]i;
    reg [2:0] sel;
    wire y;

    Mux8to1 uut (.i(i), .sel(sel), .y(y));

    integer k;
    initial begin
	$dumpfile("Mux8to1_wave.vcd");
	$dumpvars(0,Mux8to1_tb);
        i = 8'b11010110;  
        $display("    i     sel   y   expected ");
        for (k = 0; k < 8; k = k + 1) begin
            sel = k; #10;
            $display(" %8b %03b   %b     i[%0d]=%b", i, sel, y, sel, i[sel]);
        end
        $finish;
    end
endmodule

