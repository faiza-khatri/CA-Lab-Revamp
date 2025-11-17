`timescale 1ns / 1ps

module mux  # (
    parameter OPERAND_LENGTH = 31
    )(
    input [OPERAND_LENGTH:0] a,
    input [OPERAND_LENGTH:0] b,
    input s,
    output wire [OPERAND_LENGTH:0] c
    );
    

    assign c = s ? b : a;

endmodule
