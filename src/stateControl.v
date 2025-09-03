`timescale 1ns / 1ps

module stateControl(
    input clk, rst,
    input wire maxReceived,
    output reg getMaxCount, incrementCount
    );
    
   reg state, nextState;
   
localparam GET_MAX_COUNT = 1'd0;
localparam INCREMENT_COUNT = 1'd1;
   
always @(posedge clk) 
begin
    if (rst)
        state <= getMaxCount;
    else
        state <= nextState;
end

always @(*) 
begin
    // Default outputs
    getMaxCount = 0;
    incrementCount = 0;
    
    case (state)
        GET_MAX_COUNT:
        begin
            getMaxCount = 1'b1;
            nextState = maxReceived ? INCREMENT_COUNT : GET_MAX_COUNT;
        end
        INCREMENT_COUNT:
        begin
            incrementCount = 1'b1;
            nextState = INCREMENT_COUNT;
        end
        default: 
        begin
            nextState = GET_MAX_COUNT;
        end
    endcase
end



    
endmodule
