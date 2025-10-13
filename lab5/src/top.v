`timescale 1ns / 1ps


module top(
    input clk,
    input btnC, btnU,
    output [6:0] seg,           // 7-segment segments (a-g)
    output [3:0] an
    );
    
    wire btnInc, btnRst;
    assign btnInc = btnC;
    assign btnRst = btnU;
    
    wire increaseDelay, rst;
    debouncer deb1 (.clk(clk), .pbin(btnInc), .pbout(increaseDelay));
    debouncer deb2 (.clk(clk), .pbin(btnRst), .pbout(rst));
    
    wire [63:0] currentDelay;
    setDelay setDelayInst(.clk(clk), .rst(rst), .increaseDelay(increaseDelay), .delaySet(currentDelay));
    
    wire [15:0] count;
    
    // to be changed when user configurable max count is implemented
    wire [15:0] maxCount = 16'hFFFF;
    wire incrementCount = 1;
    
    wire incremented; // pulse to indicate incement clock cycle
    increment inc (.clk(clk), .rst(rst), .delaySet(currentDelay), 
    .signal(incrementCount), .maxCount(maxCount), .incremented(incremented), 
    .count(count)
    );
    
    segTop display(
        .clk(clk), .rst(rst),
        .writeEnable(incremented),
        .writeData({16'b0, count}),
        .readEnable(1'b0),
        .memAddress(64'b0),
        .seg(seg),
        .an(an)
        );
    
//    wire switchDigit;
//    wire [1:0] digitSelect;
//    counter countInst(.clk(clk), .rst(rst), .switchDigit(switchDigit));
//    segControl(.clk(clk), .rst(rst), .switchDigit(switchDigit), .digitSelect(digitSelect));
    
//    sevenSeg display(.clk(clk), .rst(rst), .count(count), .digitSelect(digitSelect), .seg(seg), .an(an));
endmodule
