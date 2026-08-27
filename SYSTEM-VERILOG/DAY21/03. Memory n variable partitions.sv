// Memory n variable partitions
class memory_block;
  bit[31:0] mem_ram_start, mem_ram_end;
  rand bit [31:0] mem_part_start[];
  rand int mem_num_parts, mem_part_size[];
  int i;
  
  constraint parts { 
    mem_num_parts >= 2;
    mem_num_parts <= 8; }
  
  constraint part_sizes { 
    mem_part_size.size() == mem_num_parts;
    mem_part_size.sum() == mem_ram_end - mem_ram_start + 1;
    foreach(mem_part_size[i])
      mem_part_size[i] inside {16,32,64,128,512,1024};
  }
  
  constraint partition {
    mem_part_start.size() == mem_num_parts;
    foreach(mem_part_start[i]) 
      if (i != 0)
        mem_part_start[i] == mem_part_start[i-1] + mem_part_size[i-1] ;
      else
        mem_part_start[i] == mem_ram_start;
      }
  
  function void disp();
    $display("-------------N variable Partition-----------");
    $display("Ram start addr :%0d", mem_ram_start);
    $display("Ram end addr :%0d", mem_ram_end);
    $display("No of partition : %0d", mem_num_parts);
  
    
    foreach (mem_part_start[i]) begin
      if(i == mem_num_parts - 1)
        $display("Partition : %0d with size : %0d from %0d to %0d",i+1, mem_part_size[i], mem_part_start[i],mem_ram_end);
      else
        $display("Partition : %0d with size : %0d from %0d to %0d",i+1, mem_part_size[i], mem_part_start[i],mem_part_start[i+1]-1);
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
-------------N variable Partition-----------
Ram start addr :0
Ram end addr :2047
No of partition : 6
Partition : 1 with size : 128 from 0 to 127
Partition : 2 with size : 1024 from 128 to 1151
Partition : 3 with size : 512 from 1152 to 1663
Partition : 4 with size : 128 from 1664 to 1791
Partition : 5 with size : 128 from 1792 to 1919
Partition : 6 with size : 128 from 1920 to 2047
