`timescale 1ns / 1ps

module alu1Bit(
    input  a,
    input  b,
    input  carryIn,
    input  [3:0] ALUControl,
    output reg result,
    output carryOut
);

wire sum, and_ab, or_ab, xor_ab;
wire bFinal, aFinal;

assign aFinal = ALUControl[3] ? ~a : a;
assign bFinal = ALUControl[2] ? ~b : b;
//assign bFinal = (ALUControl == 4'b0110) ? ~b : b;

assign and_ab = aFinal & bFinal;
assign or_ab  = aFinal | bFinal;

assign {carryOut, sum} = aFinal + bFinal + carryIn;

always @(*) begin
    case (ALUControl)
        4'b0000: result = and_ab;
        4'b0001: result = or_ab;
        4'b0010: result = sum;          // add
        4'b0110: result = sum;          // sub
        4'b1100: result = and_ab;     // nor
        4'b1101: result = or_ab;      // nand
        default: result = 0;
    endcase
end

endmodule
