`timescale 1ns / 1ps

module top(
    input clk,
    input btnC,
    output [6:0] seg,           // 7-segment segments (a-g)
    output [3:0] an
    );
    
    wire rst;
    wire newOp, getOperands, operation, incrementAddress, storeResult, switchDigit;
    wire [1:0] digitSelect;
    wire carryOut;
    wire [63:0] operand1, operand2, result;
    reg [15:0] resultDisplay;
    wire [4:0] rs1, rs2;
    
    debouncer rstBtn(.clk(clk), .pbin(btnC), .pbout(rst));
    
//    assign leds = newOp;
    stateControl stateCntrl(
    .clk(clk), .rst(rst), 
    .newOp(newOp), 
    .incrementAddress(incrementAddress),
    .getOperands(getOperands), 
    .operation(operation), 
    .storeResult(storeResult)
//    .led(led)
    );
    
    delayCounter #(.DELAY(1000000000)) 
        delay(.clk(clk), .rst(rst), .indicator(newOp)
//    .led(led)
    );
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
    always @(posedge clk) begin
        if(rst) resultDisplay <= 0;
        else if(storeResult) resultDisplay <= result;
    end
    
    delayCounter #(.DELAY(1024))
    segDelay (.clk(clk), .rst(rst), .indicator(switchDigit));

    segControl(.clk(clk), .rst(rst), .switchDigit(switchDigit), .digitSelect(digitSelect));
    
    sevenSeg display(.clk(clk), .rst(rst), .result(resultDisplay), .digitSelect(digitSelect), .seg(seg), .an(an));
    
    
    
endmodule
