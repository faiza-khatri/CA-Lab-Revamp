`timescale 1ns / 1ps


module delayCounter #(parameter DELAY = 1000000000) (
    input clk,
    input rst,
    output reg indicator = 0
//    output reg [15:0] led = 0
    );
    
//    parameter DELAY = 1000000000; // low for sim, high for synth
    reg [29:0] counter = 0;
    
    always @(posedge clk) begin
//        if(indicator) led <= 15'd1;
        if(rst) begin
            counter <= 0;
            indicator <= 0;
//            led <= 0;
        end
        else begin
            if(counter == DELAY) begin
                counter <= 0;
                indicator <= 1;
//                led <= 1;
            end
            else begin
                counter <= counter + 1;
                indicator <= 0;
            end
        
        end
    end
endmodule
