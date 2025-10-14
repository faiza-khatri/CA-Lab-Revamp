`timescale 1ns / 1ps


module top(
    input clk,
    input btnC, btnU,
    output [6:0] seg,           // 7-segment segments (a-g)
    output [3:0] an,
    output incrementCount,
    output increaseDelay,
    output [10:0] step
    );
    
    wire btnInc, btnRst;
    assign btnInc = btnC;
    assign btnRst = btnU;
    
    wire rst;
//    wire increaseDelay;
    debouncer deb1 (.clk(clk), .pbin(btnInc), .pbout(increaseDelay));
    debouncer deb2 (.clk(clk), .pbin(btnRst), .pbout(rst));
    
//    wire [63:0] currentDelay;
//    setDelay setDelayInst(.clk(clk), .rst(rst), .increaseDelay(increaseDelay), .delaySet(currentDelay));
    
//    wire [10:0] step;
    wire delayIncreased;
    increment #(
        .COUNT_LENGTH(10),
        .MAX_VAL(2**10),
        .DEFAULT_VALUE(1)
        ) incStep (
        .clk(clk), .rst(rst),
        .step(10'b1),
        .signal(increaseDelay),
        .count(step),
        .incremented(delayIncreased)
        );
    
    wire [15:0] count;
    
//    wire incrementCount;
    delayCounter #(
        .DELAY(100000000)
        )
        delayInst (
            .clk(clk), 
            .rst(rst),
            .step(step),
            .indicator(incrementCount)
            );
    
    wire incremented; // pulse to indicate incement clock cycle
    increment #(
        .COUNT_LENGTH(15),
        .MAX_VAL(20),
        .DEFAULT_VALUE(0)
        )
        inc (.clk(clk), .rst(rst), 
    .step(step), 
    .signal(incrementCount), 
    .incremented(incremented), 
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
    
////    wire switchDigit;
////    wire [1:0] digitSelect;
////    counter countInst(.clk(clk), .rst(rst), .switchDigit(switchDigit));
////    segControl(.clk(clk), .rst(rst), .switchDigit(switchDigit), .digitSelect(digitSelect));
    
////    sevenSeg display(.clk(clk), .rst(rst), .count(count), .digitSelect(digitSelect), .seg(seg), .an(an));
endmodule
