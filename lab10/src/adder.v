`timescale 1ns / 1ps

module adder #(
    parameter OPERAND_LENGTH = 31
    )(
    input [OPERAND_LENGTH:0] a,
    input [OPERAND_LENGTH:0] b,
    output reg [OPERAND_LENGTH:0] out
    );
    
always @(a or b)
   out = a + b;
endmodule
