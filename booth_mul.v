module adder (a, b, sum);
  input [7:0] a, b;
  output [7:0] sum;
  wire cout;
  wire [7:0] carry;
  fa fa1 (a[0], b[0], 1'b0, sum[0], carry[0]);
  fa fa2 (a[1], b[1], carry[0], sum[1], carry[1]);
  fa fa3 (a[2], b[2], carry[1], sum[2], carry[2]);
  fa fa4 (a[3], b[3], carry[2], sum[3], carry[3]);
  fa fa5 (a[4], b[4], carry[3], sum[4], carry[4]);
  fa fa6 (a[5], b[5], carry[4], sum[5], carry[5]);
  fa fa7 (a[6], b[6], carry[5], sum[6], carry[6]);
  fa fa8 (a[7], b[7], carry[6], sum[7], cout);
endmodule

module subtractor (a, b, sum);
  input [7:0] a, b;
  output [7:0] sum;
  wire [7:0] inv;
  wire cout;
  invert i1 (b[0], inv[0]);
  invert i2 (b[1], inv[1]);
  invert i3 (b[2], inv[2]);
  invert i4 (b[3], inv[3]);
  invert i5 (b[4], inv[4]);
  invert i6 (b[5], inv[5]);
  invert i7 (b[6], inv[6]);
  invert i8 (b[7], inv[7]);
  wire [7:0] carry;
  fa fa1 (a[0], inv[0], 1'b1, sum[0], carry[0]);
  fa fa2 (a[1], inv[1], carry[0], sum[1], carry[1]);
  fa fa3 (a[2], inv[2], carry[1], sum[2], carry[2]);
  fa fa4 (a[3], inv[3], carry[2], sum[3], carry[3]);
  fa fa5 (a[4], inv[4], carry[3], sum[4], carry[4]);
  fa fa6 (a[5], inv[5], carry[4], sum[5], carry[5]);
  fa fa7 (a[6], inv[6], carry[5], sum[6], carry[6]);
  fa fa8 (a[7], inv[7], carry[6], sum[7], cout);
endmodule

module booth_check (input wire signed [7:0] a, Q, input wire signed q0, input wire signed [7:0] m, output reg signed [7:0] as8, output reg signed [7:0] Qs8, output reg cq0);
  wire [7:0] addma, subma;
  adder boothadd (a, m, addma);
  subtractor boothsub (a, m, subma);
    always @(*) begin 
      if (Q[0] == q0) begin 
        cq0 = Q[0];
        Qs8 = Q >> 1;
        Qs8[7] = a[0];
        as8 = a >> 1;
        if (a[7] == 1)
          as8[7] = 1;
      end
      else if (Q[0] == 1 && q0 == 0) begin 
        cq0 = Q[0];
        Qs8 = Q >> 1;
        Qs8[7] = subma[0];
        as8 = subma >> 1;
        if (subma[7] == 1) 
          as8[7] = 1;
      end
      else begin 
        cq0 = Q[0];
        Qs8 = Q >> 1;
        Qs8[7] = addma[0];
        as8 = addma >> 1;
        if (addma[7] == 1) 
          as8[7] = 1;
      end
    end 
endmodule

module booth_multiplier (input signed [7:0] a, b, output signed [15:0] out);
  wire signed [7:0] Q1, Q2, Q3, Q4, Q5, Q6, Q7;
  wire signed [7:0] A1, A2, A3, A4, A5, A6, A7;
  wire signed [7:0] q0;
  wire qout;
  booth_check step1 (8'b00000000, a, 1'b0, b, A1, Q1, q0[1]);
  booth_check step2 (A1, Q1, q0[1], b, A2, Q2, q0[2]);
  booth_check step3 (A2, Q2, q0[2], b, A3, Q3, q0[3]);
  booth_check step4 (A3, Q3, q0[3], b, A4, Q4, q0[4]);
  booth_check step5 (A4, Q4, q0[4], b, A5, Q5, q0[5]);
  booth_check step6 (A5, Q5, q0[5], b, A6, Q6, q0[6]);
  booth_check step7 (A6, Q6, q0[6], b, A7, Q7, q0[7]);
  booth_check step8 (A7, Q7, q0[7], b, out[15:8], out[7:0], qout);
endmodule
