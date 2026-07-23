module rcatb;
    reg [3:0] A;
    reg [3:0] B;
    reg cin;
    wire [3:0] sum;
    wire cout;

    // Instantiate Design Under Test (DUT)
    rca uut (
        .A(A),
        .B(B),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        $dumpfile("rca.vcd");
        $dumpvars(0, rcatb); 

        // Test Case 1: Simple addition without carry in
        A = 4'b0010; B = 4'b0011; cin = 1'b0; #10; // 2 + 3 = 5
        
        // Test Case 2: Addition with overflow (generates carry out)
        A = 4'b1100; B = 4'b0100; cin = 1'b0; #10; // 12 + 4 = 16 (sum=0, cout=1)
        
        // Test Case 3: Maximum values with carry in
        A = 4'b1111; B = 4'b1111; cin = 1'b1; #10; // 15 + 15 + 1 = 31 (sum=15, cout=1)

        // Test Case 4: Random mix
        A = 4'b0101; B = 4'b1010; cin = 1'b0; #10; // 5 + 10 = 15

        $finish;
    end
endmodule
