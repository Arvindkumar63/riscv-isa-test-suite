module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    parameter A = 0, B = 1;
    reg state, next_state;
    reg [1:0]i, count;
    
    always @ (posedge clk) begin
        if (reset) 
            state <= A;
        else 
            state <= next_state;
    end
    
    always @ (*) begin
        case(state)
            A: next_state = s ? B:A;
            B: next_state = B;
        endcase
    end
  
     always @ (posedge clk) begin
        if (reset) begin
            i <= 0;
            count <= 0;
        end
        else begin
            if(state == B) begin
                if(i == 3) begin
                    count =0;
                    i = 0;
                end 
                if (w==1) 
                    count = count +1;
                i=i+1;
            end
        end
    end
    
    assign z = ((i == 3) && (count ==2)) ? 1 : 0;
            
endmodule
