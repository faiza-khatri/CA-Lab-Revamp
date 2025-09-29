`timescale 1ns / 1ps

module addressCounter(
    input clk,
    input rst,
    input incrementAddress,
    output reg [4:0] address
    );
    
    always @(posedge clk) begin
        if(rst) address = 0;
        else if(incrementAddress) address = address == 5'd30 ? 0 : address + 2;
    end
endmodule
