module booth_mul_tb;
wire signed [15:0] y;
reg signed [7:0] a, b;
booth_multiplier samplebooth (.a(a), .b(b), .out(y));
initial begin 
  $dumpfile ("booth_mul.vcd");
  $dumpvars (0, booth_mul_tb);
end
initial begin 
  $monitor ($time, " Multiplication : %d * %d = %d",a,b,y);
  #0 a = 8'b11110000;b = 8'b11110000;
  #10 a = 8'b10010101;b = 8'b100000;
  #10 a = 8'b0111;b = 8'b0;
  #10 b = 8'b1;a = 8'b1;
  #10 a = 8'b00111100;b = 8'b0101;
  #10 a = 8'b10101010;b = 8'b100011;
  #10 a = 8'b010001;b = 8'b11100;
  #10 a = 8'b1000;b = 8'b10111111;
end 
endmodule
