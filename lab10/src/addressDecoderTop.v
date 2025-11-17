`timescale 1ns / 1ps

module addressDecoderTop #(
    parameter OPERAND_LENGTH = 31
    )(
    input clk, rst,
    input [OPERAND_LENGTH:0] address,
//    input [63:0] memAddress,
    input readEnable, writeEnable,
    input [31:0] writeData,
    input [15:0] switches,
    
    output [31:0] readData,
    output [6:0] seg,           // 7-segment segments (a-g)
    output [3:0] an
    );
    
    wire selDataMem, selSwitch, selLed;
    wire ledWriteEnable, dataMemWriteEnable;
    
    wire [31:0] dataMemReadData, switchReadData;
     
    addressDecoder #(
        .OPERAND_LENGTH(OPERAND_LENGTH)
        )decode (
        .address(address),
        .selDataMem(selDataMem),
        .selSwitch(selSwitch),
        .selLed(selLed)
        );
    
    writeDeMux writeSelect (
        .writeEnable (writeEnable),
        .selDataMem (selDataMem),
        .selLed (selLed),
        .ledWriteEnable (ledWriteEnable),
        .dataMemWriteEnable (dataMemWriteEnable)
        );
        
//    leds ledsInst (
//        .clk(clk),
//        .rst(rst),
//        .writeData(writeData),
//        .writeEnable(ledWriteEnable),
//        .readEnable(1'b0), // output device is not read
//        .leds(leds)
//        );

    segTop sevenSegDisplay (
        .clk(clk), .rst(rst),
        .writeData(writeData),
        .writeEnable(ledWriteEnable),
        .readEnable(1'b0), // output device is not read
        .memAddress(address[29:0]),
        .seg(seg),
        .an(an)
        );
    
    switches switchesInst (
        .clk(clk),
        .rst(rst),
        .writeEnable(1'b0), // input device is not written
        .writeData(32'b0),
        .switches(switches),
        .memAddress(address[29:0]),
        .readEnable(readEnable && selSwitch),
        .readData(switchReadData)
        );
    
    dataMemory dataMem (
        .clk(clk),
        .rst(rst),
        .writeEnable(dataMemWriteEnable),
        .writeData(writeData),
        .memAddress(address[29:0]),
        .readEnable(readEnable && selDataMem),
        .readData (dataMemReadData)
        );
        
    readMux readSelect (
        .dataMemReadData (dataMemReadData),
        .switchReadData(switchReadData),
        .selDataMem(selDataMem),
        .selSwitch(selSwitch),
        .readEnable(readEnable),
        .readData(readData)
        );
endmodule
