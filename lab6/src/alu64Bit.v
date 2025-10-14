`timescale 1ns / 1ps

module aluNBit#(
    parameter OPERAND_LENGTH = 31
    )(
    input  [OPERAND_LENGTH:0] a,
    input  [OPERAND_LENGTH:0] b,
    input  [3:0] ALUOp,
    output [OPERAND_LENGTH:0] result,
    output zero, lessThan,
    output carryOut
);

wire [OPERAND_LENGTH:0] carry;
wire [OPERAND_LENGTH:0] res;

reg [OPERAND_LENGTH:0] resSlli = 0;

assign zero = (res == 0);
assign lessThan = (res[OPERAND_LENGTH]); // if res is negative
assign carryOut = carry[OPERAND_LENGTH];


genvar i;
generate
    for (i = 0; i < OPERAND_LENGTH+1; i = i + 1) begin : alu_loop

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


always @(ALUOp) begin
   resSlli = a >> b;
end

assign result = (ALUOp == 4'b0100) ? resSlli : res;


endmodule
