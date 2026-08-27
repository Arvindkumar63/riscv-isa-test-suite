module count_zeroes_tb;
    reg [14:0] data;
    wire [3:0] out;

    count_zeroes uut (.data(data), .out(out));

    initial begin
        $monitor("Time=%0t data=%b | Count_of_Zeros=%d", $time, data, out);

        data = 15'b101010101000110;  #10;
        data = 15'b111111111111111;  #10;
        data = 15'b000000000000000;  #10;
        data = 15'b100110011010101;  #10;
        $finish;
    end
endmodule
