// Vehicle ex - super.new
class Vehicle;
  string model_name;
  function new (string model_name);
    this.model_name = model_name;
    $display("Vehicle Model = %s",model_name);
  endfunction
endclass

class Car extends Vehicle;
  string colour;
  function new (string model_name,string colour);
    super.new(model_name);
    this.colour = colour;
    $display("Car Colour = %s",colour);
  endfunction
endclass

module example;
  Car c;
  initial begin
    c = new("Lancer","BLACK");
  end
endmodule
