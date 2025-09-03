`timescale 1ns / 1ps
module increment(
    input clk, rst,
    input [31:0] delaySet,
    input  signal,
    input [15:0] maxCount,
    output reg incremented, // pulse to indicate counter increase
    output reg [15:0] count // FFFF max
    );
    
    reg [31:0] delay;
    initial begin
        count = 0;
        delay = 10000;
    end

     
    always @(posedge clk) begin
        if(rst) begin
            count <= 0;
            delay <= 0;
            incremented <= 0;
        end
        else begin
            if(signal) begin
                if(delay < delaySet) begin
                    delay <= delay + 1;
                    incremented <= 0;
                end
                else begin 
                    delay <= 0;
                    count <= (count == maxCount) ? 0 : count + 1;
                    incremented <= 1;
                end
            end
            else begin
                delay <= 0;
                incremented <= 0;
            end
//            else if(signal==2'd2) count = count == 0 ? 16'hFFFF : count - 1;
        end

    end
    
    
endmodule