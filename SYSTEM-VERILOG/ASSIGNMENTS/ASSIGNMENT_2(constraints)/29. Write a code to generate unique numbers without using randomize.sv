// Write a code to generate unique numbers without using randomize.
module unique_numbers;
  int q[$];
  int num;

  initial begin
    while (q.size() < 10) begin
      num = $urandom_range(0, 99);

      if (!(num inside {q})) begin
        q.push_back(num);
      end
    end
    $display("Unique Queue = %0p", q);
  end
endmodule

//OUTPUT
Unique Queue = 53 22 90 72 59 12 47 70 91 81
