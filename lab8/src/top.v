`timescale 1ns / 1ps

module top(
    input clk, btnC,
    input [15:0] sw,
    output [15:0] led
    );
    
    wire rst;
    wire [31:0] address;
    wire readEnable, writeEnable;
    wire [31:0] readData, writeData;
    
    debouncer db (
        .clk(clk),
        .pbin(btnC),
        .pbout(rst)
    );
    
    stateControl stateCtrl (
        .clk(clk), .rst(rst),
        .writeData(readData), // what is read from mem device will be written to another
        .address(address),
        .readEnable(readEnable),
        .readData(writeData), // what is written to a mem device will be read from another
        .writeEnable(writeEnable)
        );
    addressDecoderTop addressDecoderInst (
        .clk(clk), .rst(rst),
        .address(address),
        .memAddress(64'b0), // for this purpose, write to a single mem location (can be changed if needed)
        .readEnable(readEnable),
        .writeEnable(writeEnable),
        .writeData(writeData),
        .switches(sw),
        .readData(readData),
        .leds(led)
        );
    
    
endmodule