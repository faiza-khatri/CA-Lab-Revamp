`timescale 1ns / 1ps

module segControl(
    input clk, rst,
    input switchDigit,
    output reg [3:0] digitSelect
    );
    
// digit selection states
localparam d0 = 2'd0;
localparam d1 = 2'd1;
localparam d2 = 2'd2;
localparam d3 = 2'd3;

reg [1:0] state, nextState;

always @(posedge clk) begin
    if(rst) begin
        state <= d0;
    end else begin
        state <= nextState;
    end
 end  
  
 always @(*) begin
    case(state)
        d0: begin
            digitSelect <= 2'd0;
            nextState <= switchDigit ? d1 : d0;
       end
       d1: begin
            digitSelect <= 2'd1;
            nextState <= switchDigit ? d2 : d1;
       end
       d2: begin
            digitSelect <= 2'd2;
            nextState <= switchDigit ? d3 : d2;
       end
       d3: begin
            digitSelect <= 2'd3;
            nextState <= switchDigit ? d0 : d3;
       
       end
       
    endcase
 
 end


endmodule
