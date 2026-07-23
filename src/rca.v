`default_nettype none

module full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (cin & (a ^ b));
endmodule

module rca (
    input  wire [3:0] A,
    input  wire [3:0] B,
    input  wire       cin,
    output wire [3:0] sum,
    output wire       cout
);
    wire c1, c2, c3;

    full_adder fa0 ( .a(A[0]), .b(B[0]), .cin(cin), .sum(sum[0]), .cout(c1)   );
    full_adder fa1 ( .a(A[1]), .b(B[1]), .cin(c1),  .sum(sum[1]), .cout(c2)   );
    full_adder fa2 ( .a(A[2]), .b(B[2]), .cin(c2),  .sum(sum[2]), .cout(c3)   );
    full_adder fa3 ( .a(A[3]), .b(B[3]), .cin(c3),  .sum(sum[3]), .cout(cout) );

endmodule
