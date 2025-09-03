`timescale 1ns / 1ps

module setDelay(
    input clk, rst,
    input wire increaseDelay,
    output reg [31:0] delaySet
    );
    
    reg  increaseDelayPrev;
    initial begin
        delaySet = 10000;
        increaseDelayPrev <= 0;
    end
    
    always @(posedge clk) begin
        if(rst) begin
            delaySet <= 10000;
        end else begin
                increaseDelayPrev <= increaseDelay;
                if (increaseDelay & ~increaseDelayPrev) delaySet <= delaySet == 32'hFFFFFFFF ? 10000 : delaySet + 10000;
            end
        
        end
endmodule
