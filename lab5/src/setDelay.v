`timescale 1ns / 1ps

module setDelay (
    input clk, rst,
    input wire increaseDelay,
    output reg [63:0] delaySet
    );
    
    reg  increaseDelayPrev;
    localparam DEFAULT_DELAY = 100000000; // delay of 1 s
    
    initial begin
        delaySet = DEFAULT_DELAY;
        increaseDelayPrev <= 0;
    end
    
    always @(posedge clk) begin
        if(rst) begin
            delaySet <= DEFAULT_DELAY;
        end else begin
                increaseDelayPrev <= increaseDelay;
                if (increaseDelay & ~increaseDelayPrev) delaySet <= delaySet == 64'hFFFFFFFFFFFFFFFF ? DEFAULT_DELAY : delaySet + DEFAULT_DELAY;
            end
        
        end
endmodule
