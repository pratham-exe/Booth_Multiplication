module booth_mul_tb;
wire signed [15:0] y;
reg signed [7:0] a, b;
wire signed [7:0] Aa0, Aa1, Aa2, Aa3, Aa4, Aa5, Aa6, Aa7;
wire signed [7:0] Qa0, Qa1, Qa2, Qa3, Qa4, Qa5, Qa6, Qa7;
wire signed [7:0] qa0;
reg signed [7:0] acc;
reg signed imp;
booth_multiplier samplebooth (.a(a), .b(b), .out(y));
booth_check case1 (.a(acc), .Q(a), .q0(imp), .m(b), .as8(Aa0), .Qs8(Qa0), .cq0(qa0[0]));
booth_check case2 (.a(acc), .Q(Qa0), .q0(imp), .m(b), .as8(Aa1), .Qs8(Qa1), .cq0(qa0[1]));
booth_check case3 (.a(acc), .Q(Qa1), .q0(imp), .m(b), .as8(Aa2), .Qs8(Qa2), .cq0(qa0[2]));
booth_check case4 (.a(acc), .Q(Qa2), .q0(imp), .m(b), .as8(Aa3), .Qs8(Qa3), .cq0(qa0[3]));
initial begin 
  $dumpfile ("booth_mul.vcd");
  $dumpvars (0, booth_mul_tb);
end
initial begin 
  #0 a = 8'b01100100; b = 8'b11111000;
  $monitor ($time, " Multiplication : %d * %d = %d", a, b, y);
  #10 acc = 8'b00000000; imp = 1'b0;
  $monitor ($time, " Step 1 : %b %b %b", Aa0, Qa0, qa0[0]);
  #10 acc = Aa0; imp = qa0[0];
  $monitor ($time, " Step 2 : %b %b %b", Aa1, Qa1, qa0[1]);
  #10 acc = Aa1; imp = qa0[1];
  $monitor ($time, " Step 3 : %b %b %b", Aa2, Qa2, qa0[2]);
  #10 acc = Aa2; imp = qa0[2];
  $monitor ($time, " Step 4 : %b %b %b", Aa3, Qa3, qa0[3]);
end 
endmodule
