// Memory block randomization
class memory_block;
  bit[31:0] mem_ram_start, mem_ram_end;
  rand bit [31:0] mem_start_addr, mem_end_addr;
  rand int block_size;
  
  constraint c1{ 
    mem_start_addr >= mem_ram_start;
    mem_start_addr < mem_ram_end;
    mem_start_addr%4 == 0;
    mem_end_addr == mem_start_addr + block_size - 1;}
  constraint c2{ block_size inside {32, 64, 128};}
  
  function void disp();
    $display("-------------Memory block-----------");
    $display("Ram start addr :%0d", mem_ram_start);
    $display("Ram end addr :%0d", mem_ram_end);
    $display("Block start : %0d", mem_start_addr);
    $display("Block end : %0d", mem_end_addr);
    $display(" Block size: %0d", block_size);
  endfunction
endclass

module tb;
  memory_block mem;
  initial begin
    mem = new();
    mem.mem_ram_start = 32'h0;
    mem.mem_ram_end = 32'h7ff; //(2047)
    mem.randomize();
    mem.disp();
  end
endmodule


//OUTPUT
# KERNEL: -------------Memory block-----------
# KERNEL: Ram start addr :0
# KERNEL: Ram end addr :2047
# KERNEL: Block start : 1676
# KERNEL: Block end : 1739
# KERNEL:  Block size: 64


