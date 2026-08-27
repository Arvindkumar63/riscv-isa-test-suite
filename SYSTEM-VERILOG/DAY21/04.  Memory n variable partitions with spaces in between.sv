// Memory n variable partitions with spaces in between
class memory_block;
  bit[31:0] mem_ram_start, mem_ram_end;
  rand bit [31:0] mem_part_start[];
  rand int mem_num_parts, mem_part_size[], mem_space[];
  int i;
  
  constraint parts { 
    mem_num_parts >= 2;
    mem_num_parts <= 8; }
  
  constraint part_sizes { 
    mem_part_size.size() == mem_num_parts;
    mem_space.size() == mem_num_parts-1;
    mem_part_size.sum() + mem_space.sum()== mem_ram_end - mem_ram_start + 1;
    foreach(mem_part_size[i])
      mem_part_size[i] inside {16,32,64,128,512,1024};
    foreach(mem_space[i])
      mem_space[i] inside {16,32,64};
  }
  
  constraint partition {
    mem_part_start.size() == mem_num_parts;
    foreach(mem_part_start[i]) 
      if (i != 0)
        mem_part_start[i] == mem_part_start[i-1] + mem_part_size[i-1] + mem_space[i-1] ;
      else
        mem_part_start[i] == mem_ram_start;
      }
  
  function void disp();
    $display("-------------N variable Partition with space in between -----------");
    $display("RAM start addr :%0d", mem_ram_start);
    $display("RAM end addr :%0d", mem_ram_end);
    $display("No of partition : %0d", mem_num_parts);
  
    
    foreach (mem_part_start[i]) begin
      if(i == mem_num_parts - 1) 
        $display("Partition : %0d with size : %0d from %0d to %0d",i+1, mem_part_size[i], mem_part_start[i],mem_ram_end);
      else begin
        $display("Partition : %0d with size : %0d from %0d to %0d",i+1, mem_part_size[i], mem_part_start[i],mem_part_start[i+1]-1);
        $display("Space between %0d to %0d is %0d ", i+1,i+2,mem_space[i]);
      end
    end
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
-------------N variable Partition with space in between -----------
RAM start addr :0
RAM end addr :2047
No of partition : 7
Partition : 1 with size : 64 from 0 to 127
Space between 1 to 2 is 64 
Partition : 2 with size : 32 from 128 to 191
Space between 2 to 3 is 32 
Partition : 3 with size : 512 from 192 to 767
Space between 3 to 4 is 64 
Partition : 4 with size : 512 from 768 to 1295
Space between 4 to 5 is 16 
Partition : 5 with size : 64 from 1296 to 1375
Space between 5 to 6 is 16 
Partition : 6 with size : 512 from 1376 to 1919
Space between 6 to 7 is 32 
Partition : 7 with size : 128 from 1920 to 2047
