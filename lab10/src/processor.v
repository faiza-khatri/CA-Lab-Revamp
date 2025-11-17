`timescale 1ns / 1ps

module processor #(
    parameter OPERAND_LENGTH = 31
    )(
    input clk,
    input rst,
    
    input [OPERAND_LENGTH: 0] readDataMem,
    output [OPERAND_LENGTH:0] memAddress,
    output [OPERAND_LENGTH:0] writeDataMem,
    output memRead, memWrite,
    
    output [15:0] leds
    
    );
    
    
    wire [OPERAND_LENGTH:0] seqOut, PCIn, PCOut;
    wire [OPERAND_LENGTH:0] writeDataReg;
    
    assign leds[0] = rst;
    assign leds[15:1] = 0;
    
    
    programCounter #(
        .OPERAND_LENGTH(OPERAND_LENGTH)
        ) pc (
        .clk(clk),
        .rst(rst),
        .PCIn(PCIn),
        .PCOut(PCOut)
        );
    
    adder adderSeq (
        .a(PCOut),
        .b( { {(OPERAND_LENGTH-3){1'b0}}, 4'd4 } ),
        .out(seqOut)
        );

    wire [31:0] instruction;
        
    instructionMemory #(
        .OPERAND_LENGTH(OPERAND_LENGTH)
        ) instMem (
        .instAddress(PCOut),
        .instruction(instruction)
        );
        
    wire [6:0] opcode = instruction[6:0];
    // wire memRead, memWrite;
    wire regWrite, memToReg, branch, ALUSrc;
    wire [1:0] ALUOp;
    controlUnit ctrlUnit (
        .opcode(opcode),
        .ALUOp(ALUOp),
        .regWrite(regWrite),
        .memRead(memRead),
        .memWrite(memWrite),
        .memToReg(memToReg),
        .ALUSrc(ALUSrc),
        .branch(branch)
        );
        
    wire [4:0] rs1 = instruction[19:15];
    wire [4:0] rs2 = instruction[24:20];
    wire [4:0] rd = instruction[11:7];
    wire [OPERAND_LENGTH:0] readData1, readData2;
    registerFile #(
        .OPERAND_LENGTH(OPERAND_LENGTH)
        ) regFile (
        .clk(clk),
        .rst(rst),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .regWrite(regWrite),
        .writeData(writeDataReg),
        .readData1(readData1),
        .readData2(readData2)
        );
        
    wire [OPERAND_LENGTH:0] secondOperand;
    wire [OPERAND_LENGTH:0] immOut;
    mux #(.OPERAND_LENGTH(OPERAND_LENGTH)) operandMux(
        .a(readData2),
        .b(immOut),
        .s(ALUSrc),
        .c(secondOperand)
        );
        
    wire [3:0] operation;
    wire [3:0] funct = {instruction[30], instruction[14:12]};
    aluControl aluCtrl (
        .ALUOp(ALUOp),
        .funct(funct),
        .operation(operation)
        );
    
    wire [OPERAND_LENGTH:0] ALUResult;
    wire carryOut, zero;
    
    assign memAddress = ALUResult;
    assign writeDataMem = readData2;
    
    aluNBit #(.OPERAND_LENGTH(OPERAND_LENGTH)) alu64Bit  (
        .a(readData1),
        .b(secondOperand),
        .ALUOp(operation),
        .result(ALUResult),
        .carryOut(carryOut),
        .zero(zero)
        );
        
    mux #(.OPERAND_LENGTH(OPERAND_LENGTH)) selectWrite (
        .a(ALUResult),
        .b(readDataMem),
        .s(memToReg),
        .c(writeDataReg)
        );
    
    immGen #(.OPERAND_LENGTH(OPERAND_LENGTH)) immGenerator (
        .instruction(instruction),
        .imm(immOut)
        );
        
    wire [OPERAND_LENGTH:0] branchOut;
//    wire [63:0] imm = {32'b0, immOut};
    adder adderBranch (
        .a(immOut),
        .b(PCOut),
        .out(branchOut)
        );
        
    wire isBne = (opcode == 7'b1100011) && (instruction[14:12] == 3'b001); // funct3 for bne
    wire branchTaken = branch && ((isBne) ? ~zero : zero);

        
    mux #(.OPERAND_LENGTH(63)) nextAddress (
        .a(seqOut),
        .b(branchOut),
        .s(branchTaken),
        .c(PCIn)
        );
        
   
    
        
    
endmodule
