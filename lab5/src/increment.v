`timescale 1ns / 1ps
module increment(
    input clk, rst,
    input [63:0] delaySet,
    input  signal,
    input [15:0] maxCount,
    output reg incremented, // pulse to indicate counter increase
    output reg [15:0] count // FFFF max
    );
    
    reg [63:0] delay;
    initial begin
        count = 0;
        delay = 10000;
    end

     // 10ns = 1 clock cycle
     // 20 sec = 20 x 10^8 clock cycles (time period after which it should reset)
     // time = delay * maxCount
     // maxCount = (20 x 10^9) / delaySet

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
                    count <= (count == 512/(delaySet/100000000)) ? 0 : count + 1;
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