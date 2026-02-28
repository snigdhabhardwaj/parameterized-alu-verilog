module tb;

parameter WIDTH = 8;

reg [WIDTH-1:0] A;
reg [WIDTH-1:0] B;
reg [3:0] opcode;

wire [WIDTH-1:0] result;
wire zero;
wire carry;
wire sign;

alu #(WIDTH) dut (
    .A(A),
    .B(B),
    .opcode(opcode),
    .result(result),
    .zero(zero),
    .carry(carry),
    .sign(sign)
);

initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0,tb);

    $display("Starting ALU Simulation");

    // ADD
    A = 10; B = 5; opcode = 4'b0000; #10;

    // SUB
    A = 10; B = 5; opcode = 4'b0001; #10;

    // AND
    A = 6; B = 3; opcode = 4'b0010; #10;

    // OR
    A = 6; B = 3; opcode = 4'b0011; #10;

    // XOR
    A = 6; B = 3; opcode = 4'b0100; #10;

    // NOT
    A = 8'b10101010; opcode = 4'b0101; #10;

    // Shift Left
    A = 8'b11110000; opcode = 4'b0110; #10;

    // Shift Right
    A = 8'b11110000; opcode = 4'b0111; #10;

    // Increment
    A = 7; opcode = 4'b1000; #10;

    // Decrement
    A = 7; opcode = 4'b1001; #10;

    $display("Simulation Finished");

end

initial begin
    $monitor("time=%0t A=%d B=%d opcode=%b result=%d carry=%b zero=%b sign=%b",
    $time, A, B, opcode, result, carry, zero, sign);
end

endmodule