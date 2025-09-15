`timescale 1ns / 1ps

module alu64Bit(
    input  [63:0] a,
    input  [63:0] b,
    input  [3:0] ALUOp,
    output [63:0] result,
    output zero,
    output carryOut
);

wire [63:0] carry;
wire [63:0] res;

assign zero = (res == 64'b0);
assign carryOut = carry[63];

genvar i;
generate
    for (i = 0; i < 64; i = i + 1) begin : alu_loop

            alu1Bit aluInst (
                .a(a[i]),
                .b(b[i]),
                .carryIn( (i==0) ? (ALUOp == 4'b0110) ? 1'b1 : 1'b0 : carry[i-1]),
                .ALUOp(ALUOp),
                .result(res[i]),
                .carryOut(carry[i])
            );
    end
endgenerate

assign result = res;

endmodule
