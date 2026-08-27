module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter LEFT = 0, RIGHT = 1, FALL_L = 2, FALL_R = 3, DIG_L = 4, DIG_R = 5, SPLAT = 6;
    reg [2:0] state,next_state;
    reg [7:0] count;
    
    always @ (posedge clk or posedge areset) begin
        if(areset) begin
            state <= LEFT;
            count <= 0;
        end
        else if ( (state==FALL_L) || (state==FALL_R) ) begin
            state <= next_state;
            count <= count+1;
        end
        else begin
            state <= next_state;
            count <= 0;
        end
    end
    
    always @(*) begin
        case(state)
            LEFT : next_state = (ground==0)? FALL_L : (dig)? DIG_L : bump_left? RIGHT : LEFT ;
            RIGHT: next_state = (ground==0)? FALL_R : (dig)? DIG_R : bump_right? LEFT : RIGHT;
            FALL_L: next_state = (ground==0)? FALL_L : (count>19)? SPLAT : LEFT ;
            FALL_R: next_state = (ground==0)? FALL_R : (count>19)? SPLAT : RIGHT ;
            DIG_L: next_state = ground ? DIG_L : FALL_L;
            DIG_R: next_state = ground ? DIG_R : FALL_R;
            SPLAT: next_state = SPLAT;
        endcase
    end

    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);
    assign aaah = (state == FALL_L) || (state == FALL_R);
    assign digging = (state == DIG_L) || (state == DIG_R);

endmodule
