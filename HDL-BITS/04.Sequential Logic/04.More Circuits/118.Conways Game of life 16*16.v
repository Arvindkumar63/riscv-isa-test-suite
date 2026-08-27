module cell_value(
    input [7:0] neigh,
    input current,
    output next );

    wire [3:0] pop;   

    assign pop = neigh[0] + neigh[1] + neigh[2] + neigh[3] + neigh[4] + neigh[5] + neigh[6] + neigh[7];

    always @(*) begin
        case (pop)
            2: next = current;
            3: next = 1;
            default: next = 0;
        endcase
    end
endmodule


module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
); 
    wire [255:0] next;
    
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= next;
    end

    genvar x, y;
    generate
        for (x = 0; x < 16; x = x + 1) begin : gen_x
            for (y = 0; y < 16; y = y + 1) begin : gen_y
                cell_value val(
                    .neigh({
                        q[(x==0 ? 15 : x-1) + (y==0 ? 15 : y-1)*16],
                        q[(x==0 ? 15 : x-1) + y*16],
                        q[(x==0 ? 15 : x-1) + (y==15 ? 0 : y+1)*16],
                        q[x + (y==0 ? 15 : y-1)*16],
                        q[x + (y==15 ? 0 : y+1)*16],
                        q[(x==15 ? 0 : x+1) + (y==0 ? 15 : y-1)*16],
                        q[(x==15 ? 0 : x+1) + y*16],
                        q[(x==15 ? 0 : x+1) + (y==15 ? 0 : y+1)*16] }),
                    .current(q[x + y*16]),
                    .next(next[x + y*16]));
            end
        end
    endgenerate
endmodule
