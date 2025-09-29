`timescale 1ns / 1ps


module delayCounter(
    input clk,
    input rst,
    output reg newOp
    );
    
    parameter DELAY = 10; // low for sim, high for synth
    reg [26:0] counter = 0;
    always @(posedge clk) begin
        if(rst) counter = 0; 
        else begin
            if(counter == DELAY) begin
                counter <= 0;
                newOp <= 1;
            end
            else begin
                counter <= counter + 1;
                newOp <= 0;
            end
        
        end
    end
endmodule
