// Partition for program and data 
class memory_block;
    int total_mem;
    rand int pgm[], data[], space[];
    rand int max_pgms, max_pgm_size, max_data_size;
    rand int num_pgm, num_data, num_space;

    constraint nums {
        num_pgm inside {[1:max_pgms]};
        num_data inside {[1:10]};
        num_space inside {[1:10]};
    }

    constraint maxs {
        max_pgms == 10;
        max_pgm_size == 512;
        max_data_size == 128;
    }

    constraint arrays {
        pgm.size() == num_pgm;
        data.size() == num_data;
        space.size() == num_space;
    }

    constraint ram {
        foreach (pgm[i]) {
          pgm[i] dist {[128:max_pgm_size]:=75, [32:64]:/25};
            pgm[i] % 4 == 0;
        }

        foreach (data[i]) {
          data[i] inside {[64:max_data_size]};
          data[i] % 4 == 0;
        }

        foreach (space[i]) {
            space[i] inside {64, 128, 512};
        }

        total_mem == pgm.sum() + data.sum() + space.sum();
    }

    function void display();
        $display("Total_RAM : %0d ", total_mem);
        $display("No. of Programs : %0d ", num_pgm);
        $display("No. of Data blocks : %0d ", num_data);
        $display("No. of Spaces : %0d ", num_space);
        $display("Total program size : %0d , Total data size : %0d , Total space size : %0d \n",
                  pgm.sum(), data.sum(), space.sum());

        foreach (pgm[i])
            $display("Program_%0d is of %0d bytes", i, pgm[i]);
        foreach (data[i])
            $display("Data_%0d is of %0d bytes", i, data[i]);
        foreach (space[i])
          $display("Space_%0d is of %0d bytes", i, space[i]);
    endfunction
endclass

module memory_pgm_data();
    memory_block mb;

    initial begin
        mb = new();
      mb.total_mem = 6144;// (6kB)
        mb.randomize();
        mb.display();
    end
endmodule




//OUTPUT
Total_RAM : 6144 
No. of Programs : 7 
No. of Data blocks : 8 
No. of Spaces : 9 
Total program size : 2424 , Total data size : 712 , Total space size : 3008 

Program_0 is of 464 bytes
Program_1 is of 404 bytes
Program_2 is of 128 bytes
Program_3 is of 400 bytes
Program_4 is of 328 bytes
Program_5 is of 264 bytes
Program_6 is of 436 bytes
Data_0 is of 80 bytes
Data_1 is of 116 bytes
Data_2 is of 76 bytes
Data_3 is of 72 bytes
Data_4 is of 72 bytes
Data_5 is of 124 bytes
Data_6 is of 96 bytes
Data_7 is of 76 bytes
Space_0 is of 512 bytes
Space_1 is of 128 bytes
Space_2 is of 512 bytes
Space_3 is of 512 bytes
Space_4 is of 128 bytes
Space_5 is of 512 bytes
Space_6 is of 512 bytes
Space_7 is of 64 bytes
Space_8 is of 128 bytes
