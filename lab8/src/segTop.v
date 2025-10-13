`timescale 1ns / 1ps

module segTop(
    input clk,
    input rst,
    input [31:0] writeData,
    input writeEnable,
    input readEnable,
    input [31:0] memAddress,
    
    output reg  [31:0] readData = 0, // not to be read       
    output [6:0] seg,           // 7-segment segments (a-g)
    output [3:0] an
    );
    
    reg [15:0] resultDisplay;
    wire switchDigit;
    wire [1:0] digitSelect;
    
    always @(posedge clk) begin
        if(rst) resultDisplay <= 0;
        else if(writeEnable) resultDisplay <= writeData[15:0];
    end
    
    delayCounter #(.DELAY(1024))
    segDelay (.clk(clk), .rst(rst), .indicator(switchDigit));

    segControl(.clk(clk), .rst(rst), .switchDigit(switchDigit), .digitSelect(digitSelect));
    
    sevenSeg displaySeg(.clk(clk), .rst(rst), .result(resultDisplay), .digitSelect(digitSelect), .seg(seg), .an(an));
    
endmodule
