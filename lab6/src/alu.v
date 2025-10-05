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
wire bFinal, aFinal;

assign aFinal = ALUOp[3] ? ~a : a;
assign bFinal = ALUOp[2] ? ~b : b;
//assign bFinal = (ALUOp == 4'b0110) ? ~b : b;

assign and_ab = aFinal & bFinal;
assign or_ab  = aFinal | bFinal;

assign {carryOut, sum} = aFinal + bFinal + carryIn;

always @(*) begin
    case (ALUOp[1:0])
        2'b00: result = and_ab;
        2'b01: result = or_ab;
        2'b10: result = sum;          // add
        default: result = 0;
    endcase
end

endmodule
