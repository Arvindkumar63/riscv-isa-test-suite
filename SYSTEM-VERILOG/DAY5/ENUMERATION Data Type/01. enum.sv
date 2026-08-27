// ENUMERATION 
module enumeration;
  // enum Different Styles
  typedef enum { red, green, yellow, black}colour_set_1;
  //Duplicate identifier: red, green, yellow, black "see previous" error occur
  //typedef enum { red=7, green, yellow=5, black}colour_set_2;
  typedef enum { magenta=7, purple, blue=5, pink}colour_set_2;
  typedef enum { red[4] }colour_set_3;
  typedef enum { black[3] = 3}colour_set_4;
  typedef enum { red[4:7] }colour_set_5;
  typedef enum { black[3:6] = 3}colour_set_6;
  initial begin
    colour_set_1 color1;
    colour_set_2 color2;
    colour_set_3 color3;
    colour_set_4 color4;
    colour_set_5 color5;
    colour_set_6 color6;
    
    color1 = yellow; $display ("color1 = %0d, name = %s", color1, color1.name());
    color2 = purple; $display ("color2 = %0d, name = %s", color2, color2.name());
    color3 = red3; $display ("color3 = %0d, name = %s", color3, color3.name());
    color4 = black2; $display ("color4 = %0d, name = %s", color4, color4.name());
    color5 = red5; $display ("color5 = %0d, name = %s", color5, color5.name());
    color6 = black6; $display ("color6 = %0d, name = %s", color6, color6.name());
 
    // Enum type Methods
    color1 = green;
    $display ("color1.first() = %0d", color1.first());
    $display ("color1.last() = %0d", color1.last());
    $display ("color1.next() = %0d", color1.next());// next of green
    $display ("color1.prev() = %0d", color1.prev());// prev of green
    $display ("color1.num() = %0d", color1.num());
    $display ("color1.name() = %s", color1.name());
    
    //When declare integer to enum type variable
    // Invalid because of strict typing rules
  	//color1 = 0;
    //$display ("color1 = %s", color1.name());

  	// OK when explicitly cast
    color1 = colour_set_1'(2);
    $display ("color1 = %s", color1.name());

  	// OK. color1 is auto-cast to integer
    if ( color1 == 2)
      $display ("color1 is now %s", color1.name());
    
  end
endmodule
