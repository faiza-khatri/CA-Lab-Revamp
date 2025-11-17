`timescale 1ns / 1ps

module leds(
    input clk,
    input rst,
    input [31:0] writeData,
    input writeEnable,
    input readEnable,
    input [31:0] memAddress,
    
    output reg  [31:0] readData = 0, // not to be read       
    output reg [15:0] leds
    );
    
    always @(posedge clk) begin
        if(rst) leds <= 0;
        else if(writeEnable) leds <= writeData[15:0];
        // do nothing on readEnable (output device only)
    end
endmodule


