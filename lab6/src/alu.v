`timescale 1ns / 1ps

module alu1Bit(
    input  a,
    input  b,
    input  carryIn,
    input  [3:0] ALUOp,
    output reg result,
    output carryOut
);

wire sum, and_ab, or_ab, xor_ab;
wire bFinal;

assign bFinal = (ALUOp == 4'b0110) ? ~b : b;

assign and_ab = a & b;
assign or_ab  = a | b;

assign {carryOut, sum} = a + bFinal + carryIn;

always @(*) begin
    case (ALUOp)
        4'b0000: result = and_ab;
        4'b0001: result = or_ab;
        4'b0010: result = sum;          // add
        4'b0110: result = sum;          // sub
        4'b1100: result = ~(a | b);     // nor
        default: result = 0;
    endcase
end

endmodule
