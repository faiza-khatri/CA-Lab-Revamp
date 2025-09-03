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
    
    wire [31:0] currentDelay;
    setDelay setDelayInst(.clk(clk), .rst(rst), .increaseDelay(increaseDelay), .delaySet(currentDelay));
    
    wire [15:0] count;
    
    // to be changed when user configurable max count is implemented
    wire [15:0] maxCount = 16'hFFFF;
    wire incrementCount = 1;
    
    wire incremented; // pulse to indicate incement clock cycle
    increment inc (.clk(clk), .rst(rst), .delaySet(currentDelay), .signal(incrementCount), .maxCount(maxCount), .incremented(incremented), .count(count));
    
    sevenSeg display(.clk(clk), .rst(rst), .count(count), .seg(seg), .an(an));
endmodule
