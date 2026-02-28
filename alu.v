module alu #(parameter WIDTH = 8)
(
    input  [WIDTH-1:0] A,
    input  [WIDTH-1:0] B,
    input  [3:0] opcode,

    output reg [WIDTH-1:0] result,
    output zero,
    output reg carry,
    output sign
);

// Opcode definitions
localparam ADD = 4'b0000;
localparam SUB = 4'b0001;
localparam AND1 = 4'b0010;
localparam OR1  = 4'b0011;
localparam XOR1 = 4'b0100;
localparam NOT1 = 4'b0101;
localparam SLL  = 4'b0110;
localparam SRL  = 4'b0111;
localparam INC  = 4'b1000;
localparam DEC  = 4'b1001;

// Extra bit to capture carry
wire [WIDTH:0] add_temp;
wire [WIDTH:0] sub_temp;

assign add_temp = A + B;
assign sub_temp = A - B;

always @(*) begin

    carry = 0;

    case(opcode)

        ADD: begin
            result = add_temp[WIDTH-1:0];
            carry  = add_temp[WIDTH];
        end

        SUB: begin
            result = sub_temp[WIDTH-1:0];
            carry  = sub_temp[WIDTH];
        end

        AND1: result = A & B;

        OR1:  result = A | B;

        XOR1: result = A ^ B;

        NOT1: result = ~A;

        SLL: result = A << 1;

        SRL: result = A >> 1;

        INC: result = A + 1;

        DEC: result = A - 1;

        default: result = 0;

    endcase

end

assign zero = (result == 0);
assign sign = result[WIDTH-1];

endmodule