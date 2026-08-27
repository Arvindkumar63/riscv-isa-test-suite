// 01. QUEUE BUILD IN METHODS
module queue_buildin;
  int q[$];
  int j;
  initial begin
    q = {1,2,3,4,5,6};
    $display("SIZE OF QUEUE = %0d" , q.size() );
    q.insert((q.size/2)- 1,7);
    $display("After insert in n/2 position q = %0p",q);
    $display("SIZE OF QUEUE = %0d" , q.size() );
    q.insert((q.size)- 1,8);
    $display("After insert in n position q = %0p",q);
    $display("SIZE OF QUEUE = %0d" , q.size() );
    q.insert((q.size-1)-1,9);
    $display("After insert in n-1 position q = %0p",q);
    $display("SIZE OF QUEUE = %0d" , q.size() );
    
    q.delete((q.size-1)-1);
    $display("After delete in n-1 position q = %0p",q);
    $display("SIZE OF QUEUE = %0d" , q.size() );
    
    j=q.pop_front();
    $display("After pop_front j= %0d  q = %0p",j,q);
    $display("SIZE OF QUEUE = %0d" , q.size() );
    j=q.pop_back();
    $display("After pop_back j=%0d    q = %0p",j,q);
    $display("SIZE OF QUEUE = %0d" , q.size() );
    q.push_front(10);
    $display("After push_front q = %0p",q);
    $display("SIZE OF QUEUE = %0d" , q.size() );
    q.push_back(11);
    $display("After push_back q = %0p",q);
    $display("SIZE OF QUEUE = %0d" , q.size() );
    
    q.delete();
    $display("After delete() q = %0p",q);
    $display("SIZE OF QUEUE = %0d" , q.size() );
  end
endmodule
