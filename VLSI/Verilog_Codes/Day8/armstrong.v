module armstrong ( input [9:0]num, output reg isarm);
  integer temp,n,result,reminder;

  always @(*) begin
    n = 0;
    result = 0;
    reminder = 0;
    temp = num;
    while (temp != 0) begin
	    temp = temp/10;
	    n = n+1;
    end
    temp = num;
    while (temp != 0) begin
	    reminder = temp%10;
	    result = result + reminder**n;
	    temp = temp/10;
    end
    if(result == num)
	    isarm = 1;
    else
	    isarm = 0;
   end
endmodule 
