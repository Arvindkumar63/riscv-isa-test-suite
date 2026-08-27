//Try to get more keys than available keys
module semaphore_ex2;
  semaphore sem = new(6); // Create a semaphore with 6 keys
  initial begin 
    $display("In first initial block At time= %0t", $time);
    sem.get(4);  // Take 4 keys from semaphore
    $display("Thread 1: Accessing 4 keys from semaphore At time= %0t", $time);
    #5;
    sem.put(3);  // Put back 3 keys into semaphore
    $display("Thread 1: Done using 3 keys At time= %0t", $time);
    #20;
    $display("Thread 1: Still using the remaining 1 key At time= %0t", $time);
  end 

  initial begin 
    $display("In second initial block At time= %0t", $time);
    sem.get(5);  // Take 5 keys from semaphore, blocks if not available
    $display("Thread 2: Accessing 5 keys from semaphore At time= %0t", $time);
    #10;
    sem.put(5);  // Put back 5 keys into semaphore
    $display("Thread 2: Done using 5 keys At time= %0t", $time);
  end 
endmodule

//OUTPUT
In first initial block At time= 0
Thread 1: Accessing 4 keys from semaphore At time= 0
In second initial block At time= 0
Thread 1: Done using 3 keys At time= 5
Thread 2: Accessing 5 keys from semaphore At time= 5
Thread 2: Done using 5 keys At time= 15
Thread 1: Still using the remaining 1 key At time= 25
