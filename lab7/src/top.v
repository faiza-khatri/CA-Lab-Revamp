`timescale 1ns / 1ps

module top(
    input clk,
    input btnC,
    output [6:0] seg,           // 7-segment segments (a-g)
    output [3:0] an
    );
    
    wire rst;
    wire newOp, getOperands, operating, incrementAddress, storeResult;
    wire carryOut;
    wire [63:0] operand1, operand2, result;
    wire [1:0] ALUOp;
    wire [3:0] funct, operation;
    wire [4:0] rs1, rs2;
    
//    reg [15:0] resultDisplay;
    
    debouncer rstBtn(.clk(clk), .pbin(btnC), .pbout(rst));
    
//    assign leds = newOp;
    stateControl stateCntrl(
    .clk(clk), .rst(rst), 
    .newOp(newOp), 
    .incrementAddress(incrementAddress),
    .getOperands(getOperands), 
    .operation(operating), 
    .storeResult(storeResult)
//    .led(led)
    );
    
    delayCounter #(.DELAY(1000000000)) 
        delay(.clk(clk), .rst(rst), .indicator(newOp)
//    .led(led)
    );
    addressCounter address(.clk(clk), .rst(btnC), .incrementAddress(incrementAddress), .address(rs1)
//    .led(led)
    );
    
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
        
    ALUOpGenerator aluOpGen (
        .clk(clk), .rst(rst),
        .rs1(rs1),
        .ALUOp(ALUOp),
        .funct(funct)
        );
    
    aluControl aluCtrl (
        .ALUOp(ALUOp), 
        .funct(funct), 
        .operation(operation)
    );
        
    alu64Bit alu64BitInst(
        .a(operand2),
        .b(operand1),
        .ALUOp(operation),
        .result(result),
        .carryOut(carryOut));
    
    assign rs2 = rs1 + 1;
 
    
    segTop display (
        .clk(clk), .rst(rst),
        .writeData(result),
        .writeEnable(storeResult),
        .readEnable(1'b0),
        .memAddress(64'b0),
        .an(an),
        .seg(seg)
      
        );
    
endmodule
