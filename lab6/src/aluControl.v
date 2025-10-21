`timescale 1ns / 1ps

module aluControl (
    input [1:0] ALUOp,
    input [3:0] funct,
    output reg [3:0] ALUControl
    );
    
    always @(*) begin
        case(ALUOp)
            2'b00: ALUControl = funct[2:0]==3'b001 ? 4'b0100 : 4'b0010; // slli, ld/sd
            2'b01: ALUControl = 4'b0110; // beq : subtract to generate 0
            2'b10: begin // r-type inst
                case(funct) 
                    4'b0000: ALUControl = 4'b0010; // add
                    4'b1000: ALUControl = 4'b0110; // subtract
                    4'b0111: ALUControl = 4'b0000; // and
                    4'b0110: ALUControl = 4'b0001; // or
                    4'b0001:  ALUControl = 4'b0100; // slli
                endcase
            end
        endcase
    
    end
endmodule
