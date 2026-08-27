module count_ones_tb;
    reg [7:0] data;
    wire [3:0] count;

    count_ones uut (.data(data), .count(count));

    initial begin
        $monitor("Time=%0t data=%b | Count_of_Ones=%d", $time, data, count);

        data = 8'b00001111;  #10;
        data = 8'b11111111;  #10;
        data = 8'b00000000;  #10;
        data = 8'b11001100;  #10;
        $finish;
    end
endmodule
