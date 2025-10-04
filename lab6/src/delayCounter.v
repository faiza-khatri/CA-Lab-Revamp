`timescale 1ns / 1ps


module delayCounter(
    input clk,
    input rst,
    output reg newOp = 0
//    output reg [15:0] led = 0
    );
    
    parameter DELAY = 1000000000; // low for sim, high for synth
    reg [29:0] counter = 0;
    
    always @(posedge clk) begin
//        if(newOp) led <= 15'd1;
        if(rst) begin
            counter <= 0;
            newOp <= 0;
//            led <= 0;
        end
        else begin
            if(counter == DELAY) begin
                counter <= 0;
                newOp <= 1;
//                led <= 1;
            end
            else begin
                counter <= counter + 1;
                newOp <= 0;
            end
        
        end
    end
endmodule
