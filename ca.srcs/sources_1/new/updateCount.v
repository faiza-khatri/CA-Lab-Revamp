`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/01/2025 10:38:32 AM
// Design Name: 
// Module Name: updateCount
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module updateCount(
    input clk, rst,
    input [1:0] signal,
    output reg [3:0] count
    );
    
    initial count = 0;
    always @(posedge clk) begin
        if(rst) count = 0;
        else begin
            if(signal==2'd1) begin
                count = count == 9 ? 0 : count+1;
            end
            else if(signal==2'd2) begin
                count = count==0 ? 9 : count-1;
            end
        
        end
    
    end
endmodule
