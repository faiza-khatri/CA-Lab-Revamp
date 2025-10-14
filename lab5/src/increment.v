`timescale 1ns / 1ps
module increment #(
    parameter COUNT_LENGTH = 15,
    parameter MAX_VAL = 20,
    parameter DEFAULT_VALUE = 1
    ) (
    input clk, rst,
    input [10:0] step,
    input  signal,
    output reg incremented, // pulse to indicate counter increase
    output reg [COUNT_LENGTH:0] count = 1 
    );
   
    
    always @(posedge clk) begin
        if(rst) count <= DEFAULT_VALUE;
        else begin
            if(signal) begin
                count <= count == (MAX_VAL/step) ? DEFAULT_VALUE : count + 1;
                incremented <= 1;
            end
        end
    
    end
endmodule