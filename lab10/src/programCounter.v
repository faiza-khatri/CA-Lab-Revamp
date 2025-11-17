`timescale 1ns / 1ps

module programCounter #(
    parameter OPERAND_LENGTH = 31
    )(
    input clk,
    input rst,
    input [OPERAND_LENGTH:0] PCIn,
    output reg [OPERAND_LENGTH:0] PCOut
    );

initial PCOut = 64'd0;
always @ (posedge clk or posedge rst) begin
    PCOut = rst == 1'b1 ? 64'b0 : PCIn;
	end
endmodule
