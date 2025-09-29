`timescale 1ns / 1ps

module top(
    input clk,
    input rst,
    input [63:0] a, b,
    input [3:0] funct,
    input [1:0] ALUOp,
    output zero,
    output [3:0] operation,
    output [63:0] result
    );
    
    wire carryOut;
    
    aluControl aluCtrl(.ALUOp(ALUOp), .funct(funct), .operation(operation));
    alu64Bit alu(.a(a), .b(b), .ALUOp(operation), .result(result), .zero(zero), .carryOut(carryOut));
endmodule
