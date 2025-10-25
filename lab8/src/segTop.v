`timescale 1ns / 1ps

module segTop(
    input clk,
    input rst,
    input [31:0] writeData,
    input writeEnable,
    input readEnable,
    input [63:0] memAddress,
    
    output reg  [31:0] readData = 0, // not to be read       
    output [6:0] seg,           // 7-segment segments (a-g)
    output [3:0] an
    );
    
    reg [7:0] resultDisplay [3:0];
    wire switchDigit;
    wire [1:0] digitSelect;
    
    always @(posedge clk) begin
        if(rst) begin
            resultDisplay[0] <= 0;
            resultDisplay[1] <= 0;
        end
        else if(writeEnable) begin
            resultDisplay[memAddress] <= writeData[7:0];
            resultDisplay[memAddress+1] <= writeData[15:8];
            resultDisplay[memAddress+2] <= writeData[23:16];
            resultDisplay[memAddress+3] <= writeData[31:24];
        end
    end
    
    delayCounter #(.DELAY(1024))
    segDelay (.clk(clk), .rst(rst), .indicator(switchDigit));

    segControl(.clk(clk), .rst(rst), .switchDigit(switchDigit), .digitSelect(digitSelect));
    
    sevenSeg displaySeg(.clk(clk), .rst(rst), .result({resultDisplay[1], resultDisplay[0]}), .digitSelect(digitSelect), .seg(seg), .an(an));
    
endmodule
