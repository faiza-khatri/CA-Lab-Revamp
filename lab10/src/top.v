`timescale 1ns / 1ps

module top(
    input clk, btnC,
    input [15:0] sw,    
    output [6:0] seg,           // 7-segment segments (a-g)
    output [3:0] an
    );
    
    wire rst;
    wire [31:0] address;
    wire readEnable, writeEnable, writeOut;
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
        .writeEnable(writeEnable),
        .writeOut(writeOut)
        );
        
    addressDecoderTop addressDecoderInst (
        .clk(clk), .rst(rst),
        .address(address),
//        .memAddress(64'b0), // for this purpose, write to a single mem location (can be changed if needed)
        .readEnable(readEnable),
        .writeEnable(writeEnable),
        .writeData(writeData),
        .switches(sw),
        .readData(readData),
        .seg(seg),
        .an(an)
        );
    
    
endmodule