`timescale 1ns / 1ps

module top(
    input clk,
    input btnC,
    output [15:0] led
    );
    
    wire rst = btnC;
    wire newOp, getOperands, operation, incrementAddress, storeResult;
    wire carryOut;
    wire [63:0] operand1, operand2, result;
    wire [4:0] rs1, rs2;
    
    stateControl stateCntrl(
    .clk(clk), .rst(rst), 
    .newOp(newOp), 
    .incrementAddress(incrementAddress),
    .getOperands(getOperands), 
    .operation(operation), 
    .storeResult(storeResult));
    
    delayCounter delay(.clk(clk), .rst(rst), .newOp(newOp));
    addressCounter address(.clk(clk), .rst(btnC), .incrementAddress(incrementAddress), .address(rs1));
    
    assign rs2 = rs1 + 1;
    registerFile regFile(
        .writeData(result),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rs2),
        .regWrite(storeResult),
        .clk(clk),
        .rst(rst),
        .readData1(operand1),
        .readData2(operand2));
        
    alu64Bit alu64BitInst(
        .a(operand1),
        .b(operand2),
        .ALUOp(4'b0010),
        .result(result),
        .carryOut(carryOut));
    
    assign rs2 = rs1 + 1;
    
    leds ledDisplay(
        .clk(clk),
        .rst(rst),
        .result(result),
        .display(storeResult), // result may also display while in the process of storing
        .leds(led));
    
    
    
endmodule
