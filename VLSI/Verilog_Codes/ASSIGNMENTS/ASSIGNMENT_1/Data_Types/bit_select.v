module bit_select;
  reg [7:0]data;
  wire bit_value;
  
  assign bit_value=data[3];
  
  initial begin
    $monitor("TIME = %t, SELECTED_BIT = %b",$time,bit_value);
    #10;      //before 10 default wire value"x"
    data=8'b10101100;
  end

endmodule
