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
  #0 a = 8'b10111010;b = 8'b10111010;
  #10 a = 8'b10111011;b = 8'b00101000;
  #10 a = 8'b00001001;b = 8'b0;
  #10 b = 8'b1;a = 8'b1;
  #10 a = 8'b00011100;b = 8'b0111;
  #10 a = 8'b10010001;b = 8'b00101001;
  #10 a = 8'b1011;b = 8'b00101011;
  #10 a = 8'b1000;b = 8'b11100010;
end 
endmodule
