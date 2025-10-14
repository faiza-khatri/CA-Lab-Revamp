`timescale 1ns / 1ps

module topSevenSegmentCheck(
    input clk,
    output [6:0] seg,           // 7-segment segments (a-g)
    output [3:0] an 
    );
    
    reg [31:0] writeData = 32'h00002345;
    wire readData;
     
    segTop display (
        .clk(clk),
        .rst(1'b0),
        .writeData(writeData),
        .writeEnable(1'b1),
        .readEnable(1'b0),
        .memAddress(64'b0),
        .readData(readData),
        .seg(seg),
        .an(an)
        );
endmodule
