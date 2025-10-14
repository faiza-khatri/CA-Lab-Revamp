`timescale 1ns / 1ps

module ALUOpGenerator(
    input clk, rst,
    input [4:0] rs1,
    output reg [3:0] ALUOp
    );
    
    always @(posedge clk) begin
        if(rst) ALUOp <= 4'b0010;
        else begin
            if(rs1[1]) ALUOp <= 4'b0010; // add
            else ALUOp <= 4'b0110; // sub
        end
    end
endmodule
