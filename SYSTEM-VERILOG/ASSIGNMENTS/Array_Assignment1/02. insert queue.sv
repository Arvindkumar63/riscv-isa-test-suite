// Write a snippet in SV to insert one queue into another queue. (Do it with & without using array methods)
module insert_queue;
  int q1[$];
  int q2[$];
  int i;
  initial begin
    q1 = '{1,2,3,4};
    q2 = '{5,6,7,8};
    $display("Before insert: q1 = %0p  q2 = %0p",q1,q2);
    i = 2;
    foreach(q1[j]) begin
      q2.insert(i+j,q1[j]);
    end
    $display("After insert: q1 = %0p  q2 = %0p",q1,q2);
  end
endmodule

//-----------------------Expected OUTPUT----------------------
//Before insert: q1 = '{1, 2, 3, 4}  q2 = '{5, 6, 7, 8}
//After insert: q1 = '{1, 2, 3, 4}  q2 = '{5, 6, 1, 2, 3, 4, 7, 8}
