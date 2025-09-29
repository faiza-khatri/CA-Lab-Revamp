`timescale 1ns / 1ps

module top(
    input clk,
    input btnC,
    output [7:0] leds
    );
    
    wire newOp, getOperands, operation, incrementAddress, storeResult;
    wire zero, carryOut;
    wire [63:0] operand1, operand2, result;
    wire [4:0] rs1, rs2;
    
    stateControl stateCntrl(
    .clk(clk), .rst(rst), 
    .newOp(newOp), 
    .incrementAddress(incrementAddress),
    .getOperands(getOperands), 
    .operation(operation), 
    .storeResult(storeResult));
    
    delayCounter delay(.clk(clk), .rst(btnC), .newOp(newOp));
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
        .zero(zero),
        .carryOut(carryOut));
    
    assign rs2 = rs1 + 1;
    
    leds ledDisplay(
        .clk(clk),
        .rst(rst),
        .result(result),
        .display(storeResult), // result may also display while in the process of storing
        .leds(leds));
    
    
    
endmodule
