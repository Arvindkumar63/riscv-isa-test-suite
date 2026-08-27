module booth_multi(
        input clk,
        input start,
        input signed [3:0] A,
        input signed [3:0] B,
        output reg signed [7:0] out,
        output reg done
);

reg signed [3:0] Acc;
reg Q ;
reg signed[3:0] multiplier ;
reg signed [3:0] m ;
integer count ;

reg signed [3:0] Acc_next;

always @ (posedge clk) begin
        if(start) begin
                Acc <= 4'd0;
                Q <= 1'b0;
                multiplier <= A;
                m <= B;
                count <= 4;
                done <= 1'b0;
        end
        else if(count > 0) begin
                Acc_next = Acc;
                if((Q == 0) && (multiplier[0] == 1))
                        Acc_next = Acc - m;
                else if((Q == 1) && (multiplier[0] == 0))
                        Acc_next = Acc + m;
                else
                        Acc_next = Acc_next;

                {Acc, multiplier,Q} <= {Acc_next[3],Acc_next,multiplier};
                count <= count-1;
        end
        else begin
                out <= {Acc,multiplier};
                  done <= 1;
        end
end
endmodule
