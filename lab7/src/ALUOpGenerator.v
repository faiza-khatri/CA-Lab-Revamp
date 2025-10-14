`timescale 1ns / 1ps

module ALUOpGenerator(
    input clk, rst,
    input [4:0] rs1,
    output reg [1:0] ALUOp = 4'b10,
    output reg [3:0] funct
    );
    
    always @(posedge clk) begin
        if(rst) funct <= 4'b0000;
        else begin
            if(rs1[1]) funct <= 4'b0000; // add
            else funct <= 4'b0110; // sub
        end
    end
endmodule
