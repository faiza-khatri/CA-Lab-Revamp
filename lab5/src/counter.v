`timescale 1ns / 1ps

module counter(
    input clk, rst,
    output reg switchDigit
    );
    
    reg [9:0] refreshCounter;
    always @(posedge clk)
    if(rst) begin
        refreshCounter <= 0;
    end else begin
        refreshCounter <= refreshCounter + 1;
        switchDigit <= refreshCounter == 10'd0 ? 1 : 0;
    
    end
endmodule
