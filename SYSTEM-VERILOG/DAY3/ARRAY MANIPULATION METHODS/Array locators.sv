// Array locator
module array_locator;
  int q[$] = '{1,2,3,4,5};
  int tq[$];
  int d[] = {6,7,8,9,10};
  int f[7] = '{10,20,30,40,40,20,50};
  int count;
  initial begin
    $display(q.sum());
    $display(q.product());
    $display(q.min());
    $display(q.max());
    tq = (f.unique());
    $display(tq);
    tq = d.find with (item>7);
    $display(tq);
    tq = d.find_index with (item>7);
    $display(tq);
    tq = d.find_first_index with (item==7);
    $display(tq);
    tq = d.find_last with (item==9);
    $display(tq);
    tq = d.find_last_index with (item==9);
    $display(tq);
    count = d.sum with ((item>7)*32'd1);
    $display(count);
    count = d.sum with ((item>7)*item);
    $display(count);
    count = d.sum with ((item<7));
    $display(count);
    count = d.sum with ((item<7)?item:0);
    $display(count);
    $display(d.min());
    $display(d.max());
  end
endmodule
