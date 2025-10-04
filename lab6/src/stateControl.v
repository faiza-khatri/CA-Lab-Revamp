`timescale 1ns / 1ps


module stateControl(
    input clk, rst,
    input newOp,
    output reg incrementAddress = 0, getOperands = 0, operation = 0, storeResult = 0
//    output reg [15:0] led = 0
       
    );

parameter OPERATION = 3'd3;
parameter STORE_RESULT = 3'd4 ;
parameter IDLE = 3'd0;
parameter INCREMENT_ADDRESS = 3'd1;
parameter GET_OPERANDS = 3'd2;

reg [2:0] state, nextState;
//assign led = state;

always @(posedge clk) begin
//    if(getOperands) led <= 16'd1;
    if(rst) begin
        state <= IDLE;

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
            nextState <= newOp ? GET_OPERANDS : IDLE;
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
            nextState <= INCREMENT_ADDRESS;
            storeResult <= 1;
        end
        INCREMENT_ADDRESS: begin
            incrementAddress <= 1;
            nextState <= IDLE;
        end
        default:
            nextState <= IDLE;
    endcase
end
  
endmodule
