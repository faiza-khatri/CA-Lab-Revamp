`timescale 1ns / 1ps

module segTop(
    input clk, rst, 
    input displayResult,
    input [63:0] result,
    output [6:0] seg,           // 7-segment segments (a-g)
    output [3:0] an
    );
    
    reg [15:0] resultDisplay;
    wire switchDigit;
    wire [1:0] digitSelect;
    
    always @(posedge clk) begin
        if(rst) resultDisplay <= 0;
        else if(displayResult) resultDisplay <= result;
    end
    delayCounter #(.DELAY(1024))
    segDelay (.clk(clk), .rst(rst), .indicator(switchDigit));

    segControl(.clk(clk), .rst(rst), .switchDigit(switchDigit), .digitSelect(digitSelect));
    
    sevenSeg displaySeg(.clk(clk), .rst(rst), .result(resultDisplay), .digitSelect(digitSelect), .seg(seg), .an(an));
    
endmodule
