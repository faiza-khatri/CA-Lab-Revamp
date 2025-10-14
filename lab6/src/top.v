`timescale 1ns / 1ps

module top #(
    parameter OPERAND_LENGTH = 31
    )(
    input clk,
    input rst,
    input [OPERAND_LENGTH:0] a, b,
    input [3:0] funct,
    input [1:0] ALUOp,
    output zero, lessThan,
    output [3:0] operation,
    output [OPERAND_LENGTH:0] result
    );
    
    wire carryOut;
    
    aluControl aluCtrl (.ALUOp(ALUOp), .funct(funct), .operation(operation));
    aluNBit #(
    .OPERAND_LENGTH(OPERAND_LENGTH)
    )alu (.a(a), .b(b), .ALUOp(operation), .result(result), 
    .zero(zero), .lessThan(lessThan),
    .carryOut(carryOut));
endmodule
