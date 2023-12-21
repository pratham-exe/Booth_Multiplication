module invert (input wire i, output wire o);
    assign o = !i;
endmodule

module and2 (input wire i0, i1, output wire o);
    assign o = i0 & i1;
endmodule

module or2 (input wire i0, i1, output wire o);
    assign o = i0 | i1;
endmodule

module xor2 (input wire i0, i1, output wire o);
    assign o = i0 ^ i1;
endmodule

module or3 (input wire i0, i1, i2, output wire o);
    wire t;
    or2 or2_0 (i0, i1, t);
    or2 or2_1 (i2, t, o);
endmodule

module xor3 (input wire i0, i1, i2, output wire o);
    wire t;
    xor2 xor2_0 (i0, i1, t);
    xor2 xor2_1 (i2, t, o);
endmodule

module fa (input wire i0, i1, cin, output wire sum, cout);
    wire t0, t1, t2;
    xor3 _i0 (i0, i1, cin, sum);
    and2 _i1 (i0, i1, t0);
    and2 _i2 (i1, cin, t1);
    and2 _i3 (cin, i0, t2);
    or3 _i4 (t0, t1, t2, cout);
endmodule
