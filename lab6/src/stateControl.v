`timescale 1ns / 1ps


module stateControl(
    input clk, rst,
    input newOp,
    output reg incrementAddress, getOperands, operation, storeResult
       
    );

parameter OPERATION = 3'd3;
parameter STORE_RESULT = 3'd4 ;
parameter IDLE = 3'd0;
parameter INCREMENT_ADDRESS = 3'd1;
parameter GET_OPERANDS = 3'd2;

reg [2:0] state, nextState;

always @(posedge clk) begin
    if(rst) begin
        state <= OPERATION;
    end else begin
        state <= nextState;
    end
 end  
 
always @(*) begin
    getOperands <= 0;
    operation <= 0;
    incrementAddress <= 0;
    storeResult <= 0;
    case(state)
        IDLE: begin
            nextState <= newOp ? INCREMENT_ADDRESS : IDLE;
        end
        INCREMENT_ADDRESS: begin
            incrementAddress <= 1;
            nextState <= GET_OPERANDS;
        end
        GET_OPERANDS: begin
            getOperands <= 1;
            nextState <= OPERATION;
        end
        OPERATION: begin
            nextState <= STORE_RESULT;
            operation <= 1;
        end
        STORE_RESULT: begin
            nextState <= IDLE;
            storeResult <= 1;
        end
        default:
            nextState <= IDLE;
    endcase
end
  
endmodule
