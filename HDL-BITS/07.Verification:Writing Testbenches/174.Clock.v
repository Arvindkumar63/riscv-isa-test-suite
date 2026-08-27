`timescale 1ps/1ps
module top_module ( );
    reg clk;
    
    dut uut(.clk(clk));
    
    initial clk = 0;
    always begin
        #5 clk = ~clk;
    end

endmodule
