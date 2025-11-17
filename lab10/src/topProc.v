`timescale 1ns / 1ps
module topProc(
//    input clk, 
    input clk100MHz,
    input btnC,
    input [15:0] switches,
    output [6:0] seg,           // 7-segment segments (a-g)
    output [3:0] an,
    output [15:0] leds
    );
    
    parameter OPERAND_LENGTH = 31;
        
//    wire rst = btnC;
    wire rst;
    
    clockDivider clkDiv (
        .clk100MHz(clk100MHz),
        .rst(rst),
        .clkSlow(clk)
        );

    debouncer debounceBtn (
        .clk(clk100MHz),
        .pbin(btnC),
        .pbout(rst)
        );
        
    wire readEnable, writeEnable;
    wire [31:0] readData, writeData, memAddress;
    processor #(
        .OPERAND_LENGTH(OPERAND_LENGTH)
        ) processorInst (
        .clk(clk),
        .rst(rst),
        .readDataMem(readData),
        .writeDataMem(writeData),
        .memAddress(memAddress),
        .memRead(readEnable),
        .memWrite(writeEnable),
        .leds(leds)
        );
        
    addressDecoderTop #(
        .OPERAND_LENGTH(OPERAND_LENGTH)
        ) addDecode (
        .clk(clk),
        .rst(rst),
        .address(memAddress),
        .readEnable(readEnable),
        .writeEnable(writeEnable),
        .writeData(writeData),
        .switches(switches),
        .readData(readData),
        .seg(seg),
        .an(an)
        );
        
    
    
endmodule
