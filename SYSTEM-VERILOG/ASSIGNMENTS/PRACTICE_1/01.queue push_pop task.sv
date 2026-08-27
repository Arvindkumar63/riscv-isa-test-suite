// Declare Global queue -Push Data and Remove Data are the tasks;
module queue_prac;
  int q[$];
  task push_data(int a);
    begin
      q.push_front(a);
      q.push_back(a);
    end
  endtask
  task remove_data;
    begin
      q.pop_front();
      q.pop_back();
    end
  endtask
  initial begin
    q = '{1,2,3,4,5,6};
    $display("Queue = %p",q);
    push_data(9);
    $display("Queue = %p",q);
    remove_data;
    $display("Queue = %p",q);
  end
endmodule
