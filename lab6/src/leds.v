`timescale 1ns / 1ps


module leds(
    input clk, rst,
    input display,
    input [63:0] result,
    output reg [7:0] leds
    );
    
    initial leds = 0;
    
    always @(posedge clk) begin
        if(rst) leds <= 0;
        else if(display) leds <= result[7:0];
    end
endmodule
