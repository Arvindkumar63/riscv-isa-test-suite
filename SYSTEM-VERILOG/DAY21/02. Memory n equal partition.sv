// Memory n equal partitions
class memory_block;
  bit[31:0] mem_ram_start, mem_ram_end;
  rand bit [31:0] mem_part_start[];
  rand int mem_num_parts, mem_part_size;
  int i;
  
  constraint parts { 
    mem_num_parts >= 2;
    mem_num_parts <= 8; }
  
  constraint part_size { 
    mem_part_size == (mem_ram_end - mem_ram_start + 1)/mem_num_parts;
  }
  
  constraint partition {
    mem_part_start.size() == mem_num_parts;
    foreach(mem_part_start[i]) 
      if (i != 0)
        mem_part_start[i] == mem_part_start[i-1] + mem_part_size ;
      else
        mem_part_start[i] == mem_ram_start;
      }
  
  function void disp();
    $display("-------------N equal Partition-----------");
    $display("Ram start addr :%0d", mem_ram_start);
    $display("Ram end addr :%0d", mem_ram_end);
    $display("No of partition : %0d", mem_num_parts);
    $display("Size of each partition : %0d", mem_part_size);
    
    foreach (mem_part_start[i]) begin
      if(i == mem_num_parts - 1)
        $display("Partition : %0d from %0d to %0d",i+1,mem_part_start[i],mem_ram_end);
      else
        $display("Partition : %0d from %0d to %0d",i+1,mem_part_start[i],mem_part_start[i+1]-1);
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
-------------N equal Partition-----------
Ram start addr :0
Ram end addr :2047
No of partition : 6
Size of each partition : 341
Partition : 1 from 0 to 340
Partition : 2 from 341 to 681
Partition : 3 from 682 to 1022
Partition : 4 from 1023 to 1363
Partition : 5 from 1364 to 1704
Partition : 6 from 1705 to 2047
