`timescale 1ns / 1ps

module addressCounter(
    input clk,
    input rst,
    input incrementAddress,
    output reg [4:0] address
//    output reg [15:0] led = 0
    );
    
    always @(posedge clk) begin
//        led <= address;
        if(rst) address = 0;
        else if(incrementAddress) address = address == 5'd30 ? 0 : address + 2;
    end
endmodule
