// semaphore ex
module semaphore_ex3;
  semaphore car_key = new(1);
  initial begin
    fork
      begin 
        $display("Person A Waiting for car, time=%0t", $time);
        car_key.get(1);
        $display("Person A Got the car, time=%0t", $time);
        #10;
        car_key.put(1);
        $display("Person A Returning back car, time=%0t", $time);
      end
      begin 
        #1;
        $display("Person B Waiting for car, time=%0t", $time);
        void'(car_key.try_get(1));
        $display("Person B Got the car, time=%0t", $time);
        #8;
        car_key.put(1);
        $display("Person B Returning back car, time=%0t", $time);
      end 
    join
  end 

endmodule 

//OUTPUT
Person A Waiting for car, time=0
Person A Got the car, time=0
Person B Waiting for car, time=1
Person B Got the car, time=1
Person B Returning back car, time=9
Person A Returning back car, time=10
