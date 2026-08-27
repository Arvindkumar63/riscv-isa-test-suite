// 02. Typedef structure of Array
module structu_array;
  typedef struct {
    bit [3:0] opcode;
    logic [4:0] src;
    logic [4:0] dst;
  }Instr_t;
  Instr_t mem [3:0];
  initial begin
    mem[0] = '{15,16,1};
    mem[1].opcode = 4'b0011;
    mem[1].src = 5'b00101;
    mem[1].dst = 5'b00111;
    $display(mem);
  end
endmodule
