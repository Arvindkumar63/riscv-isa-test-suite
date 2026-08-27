// Foreach loop
module foreach_example;
  bit[1:0][2:0][7:0]data_p;//3d packed
  int data_up[2][3]; // 2d unpacked
  initial begin
    data_p = 48'hcafefa_ce0708;
    data_up ='{'{'hca,'hfe,'hfa},'{'hce,'h07,'h08}}; 
    $display("-------------packed array----------");
    foreach (data_p[i]) begin// initialize i from 1 bcoz of [1:0]
      $display("data_p[%0d]=0x%h",i,data_p[i]);
      foreach(data_p[i,j])begin
        $display("data_p[%0d][%0d]=0x%h",i,j,data_p[i][j]);
      end
    end
    $display("-------------unpacked array----------");
    foreach (data_up[i]) begin// initialize i from 0 bcoz of [2]
      $display("data_up[%0d]=%p",i,data_up[i]);
      foreach(data_up[i,j])begin
        $display("data_up[%0d][%0d]=0x%h",i,j,data_up[i][j]);
      end
    end
  end
endmodule
