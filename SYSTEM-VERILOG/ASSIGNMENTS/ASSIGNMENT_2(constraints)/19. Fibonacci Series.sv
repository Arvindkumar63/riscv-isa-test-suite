// Write a constraint to generate the Fibonacci series.
class fibonacci;
  rand int fibona[];
  constraint c19{
    fibona.size == 15;
    fibona[0] == 0;
    fibona[1] == 1;
    foreach(fibona[i]) if(i>1)
      fibona[i] == (fibona[i-1] + fibona[i-2]);
  }
endclass

module fibonacci_series;
  fibonacci fb;
  initial begin
    fb = new();
    void'(fb.randomize());
    $display("Fibonacci Sereies = %0p", fb.fibona);
  end
endmodule

//OUTPUT
 Fibonacci Sereies = 0 1 1 2 3 5 8 13 21 34 55 89 144 233 377
